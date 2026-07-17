"""Small-screen visual smoke test for the Flutter web preview.

The HTTP server lives in the same process so Windows always releases the port,
including when a Playwright assertion fails. The script exercises the real
Flutter widget tree rather than a separate HTML mock.
"""

import atexit

from contextlib import contextmanager
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


def tap_label(page: Page, label: str) -> None:
    semantic = page.locator(f'[aria-label="{label}"]')
    if semantic.count():
        semantic.last.click(force=True)
    else:
        page.get_by_text(label, exact=True).last.click(force=True)
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
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    browser_errors: list[str] = []

    with serve_build() as base_url, sync_playwright() as playwright:
        browser = playwright.chromium.launch(
            headless=True,
            args=["--disable-logging", "--log-level=3"],
        )

        phone = browser.new_page(
            viewport={"width": 390, "height": 844},
            device_scale_factor=1,
        )
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

        tap_label(phone, "Proyek")
        screenshot(phone, "projects-01-focus.png")
        tap_label(phone, "Panduan")
        screenshot(phone, "guides-01-empty.png")
        tap_label(phone, "Hasil")
        screenshot(phone, "results-01-empty.png")

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
