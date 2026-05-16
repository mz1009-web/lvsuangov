$env:HTTP_PROXY="http://127.0.0.1:7897"
$env:HTTPS_PROXY="http://127.0.0.1:7897"

Write-Output "=== Checking gh status ==="
$out = & "C:\Program Files\GitHub CLI\gh.exe" auth status 2>$null
$ec = $LASTEXITCODE
if ($ec -eq 0) {
    Write-Output "ALREADY_LOGGED_IN"
    exit 0
}

Write-Output "=== Starting GitHub auth ==="
Write-Output "Please visit https://github.com/login/device and enter the code shown below:"
Write-Output ""

# Run gh auth login in device flow mode
$proc = Start-Process -NoNewWindow -FilePath "C:\Program Files\GitHub CLI\gh.exe" -ArgumentList "auth login --hostname github.com --git-protocol https" -RedirectStandardOut "C:\Users\mz\AppData\Local\Temp\gh_dev_out.txt" -RedirectStandardError "C:\Users\mz\AppData\Local\Temp\gh_dev_err.txt" -PassThru

# Wait briefly for initial output
Start-Sleep -Seconds 5

# Check if there's a device code
if (Test-Path "C:\Users\mz\AppData\Local\Temp\gh_dev_err.txt") {
    $err = Get-Content "C:\Users\mz\AppData\Local\Temp\gh_dev_err.txt" -Raw
    if ($err -match "([A-Z0-9]{4}-[A-Z0-9]{4})") {
        Write-Output "CODE: $($matches[1])"
    }
    Write-Output "ERROR_CONTENT: $err"
}
if (Test-Path "C:\Users\mz\AppData\Local\Temp\gh_dev_out.txt") {
    $o = Get-Content "C:\Users\mz\AppData\Local\Temp\gh_dev_out.txt" -Raw
    Write-Output "OUTPUT_CONTENT: $o"
}

# Wait for auth to complete
Write-Output "Waiting for browser authentication..."
$proc.WaitForExit()
Write-Output "Auth process exited with code: $($proc.ExitCode)"

# Verify
$final = & "C:\Program Files\GitHub CLI\gh.exe" auth status 2>&1
Write-Output "Final status: $final"
if ($LASTEXITCODE -eq 0) {
    Write-Output "AUTH_OK"
    exit 0
} else {
    Write-Output "AUTH_FAILED"
    exit 1
}
