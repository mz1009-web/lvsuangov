$env:HTTP_PROXY="http://127.0.0.1:7897"
$env:HTTPS_PROXY="http://127.0.0.1:7897"
$env:http_proxy="http://127.0.0.1:7897"
$env:https_proxy="http://127.0.0.1:7897"
$env:NO_PROXY="localhost,127.0.0.1"

Write-Output "===== Test GitHub Connection ====="
try {
    $r = Invoke-WebRequest -Uri "https://github.com" -UseBasicParsing -TimeoutSec 15
    Write-Output "GitHub OK: $($r.StatusCode)"
} catch {
    Write-Output "GitHub FAIL: $_"
    Exit 1
}

Write-Output "===== GitHub Auth Login ====="
& "C:\Program Files\GitHub CLI\gh.exe" auth login --hostname github.com --git-protocol https 2>&1
