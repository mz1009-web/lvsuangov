$ErrorActionPreference = "Continue"
$env:HTTP_PROXY="http://127.0.0.1:7897"
$env:HTTPS_PROXY="http://127.0.0.1:7897"

Remove-Item "C:\Users\mz\AppData\Local\Temp\gh_auth_*.txt" -ErrorAction SilentlyContinue

$proc = Start-Process -NoNewWindow -FilePath "C:\Program Files\GitHub CLI\gh.exe" -ArgumentList "auth login --hostname github.com --git-protocol https" -RedirectStandardOutput "C:\Users\mz\AppData\Local\Temp\gh_auth_stdout.txt" -RedirectStandardError "C:\Users\mz\AppData\Local\Temp\gh_auth_stderr.txt" -PassThru

Start-Sleep -Seconds 5

if (Test-Path "C:\Users\mz\AppData\Local\Temp\gh_auth_stderr.txt") {
    $c = Get-Content "C:\Users\mz\AppData\Local\Temp\gh_auth_stderr.txt" -Raw
    if ($c -match "([A-Z0-9]{4}-[A-Z0-9]{4})") {
        Write-Output "CODE:$($matches[1])"
    }
}

Write-Output "WAITING_FOR_AUTH"
$proc.WaitForExit()
Write-Output "EXIT:$($proc.ExitCode)"

$s = & "C:\Program Files\GitHub CLI\gh.exe" auth status 2>&1
Write-Output "STATUS:$s"
if ($LASTEXITCODE -eq 0) { Write-Output "AUTH_OK" } else { Write-Output "AUTH_FAIL" }
