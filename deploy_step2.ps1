$ErrorActionPreference = "Stop"
$env:HTTP_PROXY="http://127.0.0.1:7897"
$env:HTTPS_PROXY="http://127.0.0.1:7897"

$projDir = "D:\Users\mz\学习\2026上\中观\绿算治策"

Set-Location $projDir

Write-Output "=== Pushing code to GitHub ==="
git remote remove origin 2>$null
git remote add origin https://github.com/mz1009-web/lvsuangov.git
git push -u origin main 2>&1
$ec = $LASTEXITCODE
if ($ec -eq 0) {
    Write-Output "PUSH_OK"
} else {
    Write-Output "PUSH_FAILED:$ec"
    exit 1
}

Write-Output "=== Deploy to Vercel ==="
Write-Output "Open this URL to deploy:"
Write-Output "https://vercel.com/new/clone?repository-url=https://github.com/mz1009-web/lvsuangov"
Write-Output "VERCEL_READY"
