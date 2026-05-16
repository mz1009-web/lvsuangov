$ErrorActionPreference = "Continue"
$env:HTTP_PROXY="http://127.0.0.1:7897"
$env:HTTPS_PROXY="http://127.0.0.1:7897"

Write-Output "START_AUTH_FLOW"

$proc = Start-Process -NoNewWindow -FilePath "C:\Program Files\GitHub CLI\gh.exe" -ArgumentList "auth login --hostname github.com --git-protocol https" -RedirectStandardOutput "C:\Users\mz\AppData\Local\Temp\gh_out2.txt" -RedirectStandardError "C:\Users\mz\AppData\Local\Temp\gh_err2.txt" -PassThru

for ($i = 0; $i -lt 60; $i++) {
    Start-Sleep -Seconds 1
    if ($proc.HasExited) {
        Write-Output "PROCESS_EXITED: $($proc.ExitCode)"
        break
    }
    if ($i -eq 8) {
        if (Test-Path "C:\Users\mz\AppData\Local\Temp\gh_err2.txt") {
            $c = Get-Content "C:\Users\mz\AppData\Local\Temp\gh_err2.txt" -Raw
            if ($c -match "([A-Z0-9]{4}-[A-Z0-9]{4})") {
                Write-Output "DEVICE_CODE:$($matches[1])"
                break
            }
        }
    }
}

Start-Sleep -Seconds 2

$stdout = ""
$stderr = ""
if (Test-Path "C:\Users\mz\AppData\Local\Temp\gh_out2.txt") { $stdout = Get-Content "C:\Users\mz\AppData\Local\Temp\gh_out2.txt" -Raw }
if (Test-Path "C:\Users\mz\AppData\Local\Temp\gh_err2.txt") { $stderr = Get-Content "C:\Users\mz\AppData\Local\Temp\gh_err2.txt" -Raw }
Write-Output "STDOUT:$stdout"
Write-Output "STDERR:$stderr"

if (!$proc.HasExited) {
    $proc.Kill()
    Write-Output "PROCESS_KILLED"
}
