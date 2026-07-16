param(
  [string]$Workspace = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

function New-SatuDuluArtwork {
  param(
    [Parameter(Mandatory)] [int]$Size,
    [Parameter(Mandatory)] [string]$Path,
    [bool]$Transparent = $false
  )

  $pixelFormat = if ($Transparent) {
    [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
  } else {
    [System.Drawing.Imaging.PixelFormat]::Format24bppRgb
  }
  $bitmap = [System.Drawing.Bitmap]::new($Size, $Size, $pixelFormat)
  $bitmap.SetResolution(144, 144)
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

  try {
    if ($Transparent) {
      $graphics.Clear([System.Drawing.Color]::Transparent)
    } else {
      $graphics.Clear([System.Drawing.ColorTranslator]::FromHtml('#F6F7F9'))
    }

    $scale = $Size / 1024.0
    $ringRect = [System.Drawing.RectangleF]::new(
      [single](244 * $scale),
      [single](244 * $scale),
      [single](536 * $scale),
      [single](536 * $scale)
    )
    $ringWidth = [single]([Math]::Max(2, 72 * $scale))
    $ringColor = if ($Transparent) { '#AEBDFB' } else { '#D9E0FF' }
    $ringPen = [System.Drawing.Pen]::new(
      [System.Drawing.ColorTranslator]::FromHtml($ringColor),
      $ringWidth
    )
    $ringPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $ringPen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round

    $dotBrush = [System.Drawing.SolidBrush]::new(
      [System.Drawing.ColorTranslator]::FromHtml('#4468F2')
    )
    try {
      # The open orbit leaves deliberate space while the single dot stays central.
      $graphics.DrawArc($ringPen, $ringRect, 34, 292)
      $dotDiameter = [single](300 * $scale)
      $dotOrigin = [single](($Size - $dotDiameter) / 2)
      $graphics.FillEllipse(
        $dotBrush,
        $dotOrigin,
        $dotOrigin,
        $dotDiameter,
        $dotDiameter
      )
    } finally {
      $ringPen.Dispose()
      $dotBrush.Dispose()
    }

    $directory = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $directory)) {
      New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }
    $bitmap.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
  } finally {
    $graphics.Dispose()
    $bitmap.Dispose()
  }
}

$masterPath = Join-Path $Workspace 'assets/brand/app-icon-master.png'
New-SatuDuluArtwork -Size 1024 -Path $masterPath

$iosDirectory = Join-Path $Workspace 'ios/Runner/Assets.xcassets/AppIcon.appiconset'
$iosIcons = @{
  'Icon-App-20x20@1x.png' = 20
  'Icon-App-20x20@2x.png' = 40
  'Icon-App-20x20@3x.png' = 60
  'Icon-App-29x29@1x.png' = 29
  'Icon-App-29x29@2x.png' = 58
  'Icon-App-29x29@3x.png' = 87
  'Icon-App-40x40@1x.png' = 40
  'Icon-App-40x40@2x.png' = 80
  'Icon-App-40x40@3x.png' = 120
  'Icon-App-60x60@2x.png' = 120
  'Icon-App-60x60@3x.png' = 180
  'Icon-App-76x76@1x.png' = 76
  'Icon-App-76x76@2x.png' = 152
  'Icon-App-83.5x83.5@2x.png' = 167
  'Icon-App-1024x1024@1x.png' = 1024
}
foreach ($entry in $iosIcons.GetEnumerator()) {
  New-SatuDuluArtwork -Size $entry.Value -Path (Join-Path $iosDirectory $entry.Key)
}

$webDirectory = Join-Path $Workspace 'web/icons'
New-SatuDuluArtwork -Size 192 -Path (Join-Path $webDirectory 'Icon-192.png')
New-SatuDuluArtwork -Size 512 -Path (Join-Path $webDirectory 'Icon-512.png')
New-SatuDuluArtwork -Size 192 -Path (Join-Path $webDirectory 'Icon-maskable-192.png')
New-SatuDuluArtwork -Size 512 -Path (Join-Path $webDirectory 'Icon-maskable-512.png')
New-SatuDuluArtwork -Size 64 -Path (Join-Path $Workspace 'web/favicon.png')

$launchDirectory = Join-Path $Workspace 'ios/Runner/Assets.xcassets/LaunchImage.imageset'
New-SatuDuluArtwork -Size 160 -Path (Join-Path $launchDirectory 'LaunchImage.png') -Transparent $true
New-SatuDuluArtwork -Size 320 -Path (Join-Path $launchDirectory 'LaunchImage@2x.png') -Transparent $true
New-SatuDuluArtwork -Size 480 -Path (Join-Path $launchDirectory 'LaunchImage@3x.png') -Transparent $true

Write-Output "Generated Satu Dulu icon assets from $masterPath"
