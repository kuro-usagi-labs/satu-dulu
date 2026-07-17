"""Small-screen visual smoke test for the Flutter web preview.

The HTTP server lives in the same process so Windows always releases the port,
including when a Playwright assertion fails. The script exercises the real
Flutter widget tree rather than a separate HTML mock.
"""

import atexit
import re

from contextlib import contextmanager
from datetime import datetime, timedelta, timezone
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from threading import Thread
from collections.abc import Iterator

from playwright.sync_api import Page, TimeoutError as PlaywrightTimeoutError
from playwright.sync_api import sync_playwright


OUTPUT_DIR = Path("build/visual-qa")
CHROMIUM_DEBUG_LOG = Path("debug.log")


def cleanup_chromium_log() -> None:
    CHROMIUM_DEBUG_LOG.unlink(missing_ok=True)


atexit.register(cleanup_chromium_log)


class QuietHandler(SimpleHTTPRequestHandler):
    def log_message(self, format: str, *args: object) -> None:
        pass


@contextmanager
def serve_build() -> Iterator[str]:
    build_dir = (Path.cwd() / "build" / "web").resolve()
    handler = partial(QuietHandler, directory=str(build_dir))
    server = ThreadingHTTPServer(("127.0.0.1", 0), handler)
    thread = Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        host, port = server.server_address
        yield f"http://{host}:{port}"
    finally:
        server.shutdown()
        server.server_close()
        thread.join(timeout=5)


def enable_accessibility(page: Page) -> None:
    placeholder = page.locator("flt-semantics-placeholder")
    if placeholder.count():
        placeholder.evaluate("element => element.click()")
        page.wait_for_timeout(300)


def click_actionable(locator) -> bool:
    for index in reversed(range(locator.count())):
        candidate = locator.nth(index)
        control = candidate.locator(
            'xpath=ancestor-or-self::*[@role="button" or @role="tab" or @role="link"][1]'
        )
        if control.count():
            control.first.click(force=True)
            return True
    return False


def tap_label(page: Page, label: str) -> None:
    named_button = page.get_by_role(
        "button",
        name=re.compile(rf"^{re.escape(label)}$", re.IGNORECASE),
    )
    if named_button.count():
        named_button.last.click(force=True)
    else:
        semantic = page.locator(f'[aria-label="{label}"]')
        if click_actionable(semantic):
            pass
        else:
            # Flutter may merge a card title and supporting copy into one
            # semantic label. Match it only after trying an actual button.
            semantic_with_copy = page.locator(f'[aria-label*="{label}"]')
            if click_actionable(semantic_with_copy):
                pass
            else:
                visible_text = page.get_by_text(label, exact=False)
                if click_actionable(visible_text):
                    pass
                elif visible_text.count():
                    visible_text.last.click(force=True)
                else:
                    labels = page.locator("[aria-label]").evaluate_all(
                        "elements => elements.map(element => element.getAttribute('aria-label'))"
                    )
                    nearby = [
                        value
                        for value in labels
                        if value and any(word.lower() in value.lower() for word in label.split())
                    ]
                    semantic_details = page.locator("[aria-label]").evaluate_all(
                        """elements => elements
                          .filter(element => (element.getAttribute('aria-label') || '')
                            .toLowerCase().includes('arah'))
                          .map(element => ({
                            tag: element.tagName,
                            role: element.getAttribute('role'),
                            tabIndex: element.getAttribute('tabindex'),
                            classes: element.getAttribute('class'),
                            parentTag: element.parentElement?.tagName,
                            parentRole: element.parentElement?.getAttribute('role'),
                            parentTabIndex: element.parentElement?.getAttribute('tabindex')
                          }))"""
                    )
                    raise RuntimeError(
                        f'No control matched "{label}". Nearby semantics: {nearby}. '
                        f"DOM details: {semantic_details}"
                    )
    page.wait_for_timeout(1_000)


def fill_label(page: Page, label: str, value: str) -> None:
    field = page.get_by_label(label, exact=True)
    field.click(force=True)
    page.wait_for_timeout(120)
    page.keyboard.press("Control+A")
    page.keyboard.type(value, delay=8)
    page.wait_for_timeout(400)


def screenshot(page: Page, name: str) -> None:
    page.mouse.move(1, 1)
    page.wait_for_timeout(250)
    page.screenshot(path=str(OUTPUT_DIR / name), full_page=False)


def open_app(page: Page, base_url: str) -> None:
    page.goto(base_url, wait_until="domcontentloaded", timeout=60_000)
    try:
        page.wait_for_load_state("networkidle", timeout=15_000)
    except PlaywrightTimeoutError:
        # Drift's web worker can keep network activity alive after Flutter is
        # already interactive. The rendered Flutter view is authoritative here.
        pass
    page.wait_for_selector("flutter-view", state="attached", timeout=30_000)
    page.wait_for_timeout(2200)
    enable_accessibility(page)


def main() -> None:
    build_entry = Path("build/web/main.dart.js")
    source_paths = [*Path("lib").rglob("*.dart"), Path("pubspec.yaml")]
    if not build_entry.exists() or any(
        source.stat().st_mtime > build_entry.stat().st_mtime
        for source in source_paths
    ):
        raise RuntimeError(
            "build/web is missing or stale; run flutter build web --release first."
        )

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    for previous in OUTPUT_DIR.glob("*.png"):
        previous.unlink()
    browser_errors: list[str] = []

    with serve_build() as base_url, sync_playwright() as playwright:
        browser = playwright.chromium.launch(
            headless=True,
            args=[
                "--disable-logging",
                "--log-level=3",
                "--use-angle=swiftshader",
                "--enable-unsafe-swiftshader",
            ],
        )

        phone_context = browser.new_context(
            viewport={"width": 390, "height": 844},
            device_scale_factor=1,
        )
        phone = phone_context.new_page()
        phone.on("pageerror", lambda error: browser_errors.append(str(error)))
        open_app(phone, base_url)
        screenshot(phone, "onboarding-01-promise.png")
        tap_label(phone, "Lanjut")
        screenshot(phone, "onboarding-02-workflow.png")
        tap_label(phone, "Lanjut")
        screenshot(phone, "onboarding-03-spaces.png")
        tap_label(phone, "Pilih fokus")
        screenshot(phone, "setup-01-direction.png")
        fill_label(phone, "Nama fokus", "Studio tutorial Flutter")
        fill_label(
            phone,
            "Apa yang ingin kamu buktikan?",
            "Menguji apakah tutorial singkat menarik calon pengguna",
        )
        fill_label(
            phone,
            "Kenapa ini penting sekarang? (opsional)",
            "Ini jalur paling dekat dengan pengguna yang ingin kubantu",
        )
        tap_label(phone, "Lanjut")
        screenshot(phone, "setup-02-finish-line.png")
        fill_label(
            phone,
            "Bukti 30 hari (opsional)",
            "Terbitkan 8 video dan mendapat 3 percakapan calon pengguna",
        )
        fill_label(
            phone,
            "Satu hasil yang akan di-Ship hari ini",
            "Terbitkan tutorial state management pertama",
        )
        tap_label(phone, "Lanjut")
        screenshot(phone, "setup-03-first-day.png")
        fill_label(phone, "Mulai dari sini", "Tulis outline tutorial")
        fill_label(phone, "Langkah 2 (opsional)", "Rekam contoh singkat")
        fill_label(phone, "Langkah 3 (opsional)", "Terbitkan dan bagikan")
        fill_label(
            phone,
            "Versi paling kecil (opsional)",
            "Tulis satu paragraf pembuka",
        )
        tap_label(phone, "Mulai 30 hari")
        page_title = phone.locator('[aria-label="Hari Ini"]')
        page_title.first.wait_for(state="attached", timeout=15_000)
        phone.wait_for_timeout(1_000)
        screenshot(phone, "today-01-focus.png")
        phone.mouse.move(190, 520)
        phone.mouse.wheel(0, 620)
        phone.wait_for_timeout(800)
        screenshot(phone, "today-02-actions.png")
        tap_label(phone, "Energi lagi rendah")
        screenshot(phone, "today-03-low-energy.png")
        # Flutter's CanvasKit semantics node exposes this card as a button but
        # does not dispatch its semantic DOM click to the underlying InkWell.
        # This fixed viewport/scroll state is intentional visual QA, so use the
        # card center to exercise the real pointer hit-test.
        phone.mouse.click(195, 686)
        phone.wait_for_timeout(1_000)
        screenshot(phone, "today-04-recovery.png")
        tap_label(phone, "Kerjakan sekarang")

        tap_label(phone, "Proyek")
        screenshot(phone, "projects-01-focus.png")
        tap_label(phone, "Panduan")
        screenshot(phone, "guides-01-empty.png")
        tap_label(phone, "Hasil")
        screenshot(phone, "results-01-empty.png")

        # Close the real daily loop so the editorial evidence state is also
        # rendered, rather than validating only an empty Results screen.
        tap_label(phone, "Hari Ini")
        tap_label(phone, "Ship Hari Ini")
        screenshot(phone, "ship-01-confirmation.png")
        tap_label(phone, "Simpan Ship Hari Ini")
        screenshot(phone, "ship-02-success.png")
        tap_label(phone, "Catat angka hasil")
        fill_label(phone, "Tayangan", "250")
        fill_label(phone, "Klik", "24")
        fill_label(phone, "Order", "3")
        fill_label(phone, "Waktu kerja", "120")
        fill_label(phone, "Pendapatan", "350000")
        fill_label(
            phone,
            "Apa yang layak diingat?",
            "Tutorial pertama mendapat klik paling banyak.",
        )
        # Move from the final textarea through the real keyboard focus order;
        # CanvasKit's fixed bottom action can otherwise sit behind its editing
        # overlay for pointer automation.
        for _ in range(6):
            phone.keyboard.press("Tab")
            active_label = phone.evaluate(
                """document.activeElement?.getAttribute('aria-label') ||
                document.activeElement?.textContent || ''"""
            )
            if "Simpan bukti" in active_label:
                break
        else:
            raise RuntimeError(
                f"Simpan bukti was not reachable by keyboard; focus={active_label!r}"
            )
        active_rect = phone.evaluate(
            """(() => {
              const rect = document.activeElement.getBoundingClientRect();
              return {x: rect.x, y: rect.y, width: rect.width, height: rect.height};
            })()"""
        )
        phone.mouse.click(
            active_rect["x"] + active_rect["width"] / 2,
            active_rect["y"] + active_rect["height"] / 2,
        )
        phone.wait_for_timeout(1_000)
        phone.wait_for_function(
            "!window.location.href.includes('/results/metric')",
            timeout=10_000,
        )
        phone.locator('[aria-label="Hasil"]').last.wait_for(
            state="visible",
            timeout=10_000,
        )
        tap_label(phone, "Hasil")
        screenshot(phone, "results-02-evidence.png")
        phone.mouse.move(190, 520)
        phone.mouse.wheel(0, 420)
        phone.wait_for_timeout(800)
        screenshot(phone, "results-03-learning.png")
        phone.mouse.wheel(0, 420)
        phone.wait_for_timeout(800)
        screenshot(phone, "results-04-insights.png")
        phone.mouse.wheel(0, 420)
        phone.wait_for_timeout(800)
        screenshot(phone, "results-05-decision.png")

        tap_label(phone, "Buka review mingguan")
        phone.mouse.move(190, 520)
        phone.mouse.wheel(0, 2_400)
        phone.wait_for_timeout(800)
        tap_label(phone, "Lanjutkan arah ini")
        screenshot(phone, "review-01-decision.png")
        phone.mouse.wheel(0, 700)
        phone.wait_for_timeout(500)
        fill_label(
            phone,
            "Satu kalimat cukup",
            "Uji tiga pembuka video dengan struktur yang sama.",
        )
        for _ in range(6):
            phone.keyboard.press("Tab")
            active_label = phone.evaluate(
                """document.activeElement?.getAttribute('aria-label') ||
                document.activeElement?.textContent || ''"""
            )
            if "Simpan review" in active_label:
                break
        else:
            raise RuntimeError(
                f"Simpan review was not reachable by keyboard; focus={active_label!r}"
            )
        active_rect = phone.evaluate(
            """(() => {
              const rect = document.activeElement.getBoundingClientRect();
              return {x: rect.x, y: rect.y, width: rect.width, height: rect.height};
            })()"""
        )
        phone.mouse.click(
            active_rect["x"] + active_rect["width"] / 2,
            active_rect["y"] + active_rect["height"] / 2,
        )
        phone.wait_for_timeout(1_500)
        phone.mouse.move(190, 520)
        phone.mouse.wheel(0, 2_000)
        phone.wait_for_timeout(800)
        screenshot(phone, "results-06-saved-decision.png")

        # Reopen the same local database 31 days later so the dedicated cycle
        # closure UI is exercised without mutating production code or fixtures.
        cycle_page = phone_context.new_page()
        cycle_page.set_viewport_size({"width": 390, "height": 844})
        cycle_page.clock.install(
            time=datetime.now(timezone.utc) + timedelta(days=31)
        )
        cycle_page.on(
            "pageerror", lambda error: browser_errors.append(str(error))
        )
        open_app(cycle_page, base_url)
        screenshot(cycle_page, "cycle-01-due.png")
        tap_label(cycle_page, "Tutup putaran ini")
        screenshot(cycle_page, "cycle-02-evidence.png")
        cycle_page.mouse.move(190, 520)
        cycle_page.mouse.wheel(0, 680)
        cycle_page.wait_for_timeout(800)
        screenshot(cycle_page, "cycle-03-decisions.png")
        tap_label(cycle_page, "Ubah pendekatan")
        cycle_page.mouse.wheel(0, 700)
        cycle_page.wait_for_timeout(500)
        fill_label(
            cycle_page,
            "Pendekatan baru",
            "Uji demo singkat dengan pembuka yang lebih konkret.",
        )
        screenshot(cycle_page, "cycle-04-pivot.png")
        tap_label(cycle_page, "Simpan dulu")
        cycle_page.mouse.wheel(0, 800)
        cycle_page.wait_for_timeout(600)
        screenshot(cycle_page, "cycle-05-park.png")
        cycle_page.close()

        # Open a fresh CanvasKit surface at compact size while reusing the
        # same browser context/database. Resizing the long-lived page can leave
        # stale black raster tiles in screenshots even though widgets are fine.
        core_compact = phone.context.new_page()
        core_compact.set_viewport_size({"width": 320, "height": 640})
        core_compact.on(
            "pageerror", lambda error: browser_errors.append(str(error))
        )
        open_app(core_compact, base_url)
        screenshot(core_compact, "today-compact-320.png")
        tap_label(core_compact, "Proyek")
        screenshot(core_compact, "projects-compact-320.png")
        tap_label(core_compact, "Panduan")
        screenshot(core_compact, "guides-compact-320.png")
        tap_label(core_compact, "Hasil")
        screenshot(core_compact, "results-compact-320.png")
        core_compact.close()

        compact = browser.new_page(
            viewport={"width": 320, "height": 640},
            device_scale_factor=1,
        )
        compact.on("pageerror", lambda error: browser_errors.append(str(error)))
        open_app(compact, base_url)
        screenshot(compact, "onboarding-compact-320.png")
        tap_label(compact, "Langsung pilih fokus")
        screenshot(compact, "setup-compact-320.png")

        browser.close()

    if browser_errors:
        raise RuntimeError("Browser errors: " + " | ".join(browser_errors))

    print(f"Visual QA screenshots: {OUTPUT_DIR.resolve()}")


if __name__ == "__main__":
    main()
