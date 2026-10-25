# Wraps sunledger.html (the bare source, also what the Claude artifact publishes) in a full
# HTML document and writes it to index.html (GitHub Pages) and www/index.html (Capacitor).
$root = Split-Path $PSScriptRoot -Parent
$src = Join-Path $root "sunledger.html"
$content = Get-Content -Raw -Encoding UTF8 $src

$head = "<!DOCTYPE html>`n<html lang=`"en`">`n<head>`n<meta charset=`"UTF-8`">`n<meta name=`"viewport`" content=`"width=device-width, initial-scale=1, viewport-fit=cover`">`n<title>Sunledger</title>"
$content = $content -replace '<title>Sunledger</title>', $head
$bodyOpen = "</style>`n</head>`n<body>`n`n<header class=`"app-head`">"
$content = $content -replace '</style>\s*\r?\n\r?\n<header class="app-head">', $bodyOpen
$content = $content.TrimEnd() + "`n</body>`n</html>`n"

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path $root "index.html"), $content, $utf8NoBom)
New-Item -ItemType Directory -Force -Path (Join-Path $root "www") | Out-Null
[System.IO.File]::WriteAllText((Join-Path $root "www\index.html"), $content, $utf8NoBom)

$c = $content
"doctype=$([regex]::Matches($c,'<!DOCTYPE').Count) head=$([regex]::Matches($c,'<head>').Count)/$([regex]::Matches($c,'</head>').Count) body=$([regex]::Matches($c,'<body>').Count)/$([regex]::Matches($c,'</body>').Count)"
