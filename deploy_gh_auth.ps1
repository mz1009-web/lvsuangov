Set-Location 'C:\'
$proc = Start-Process -NoNewWindow -FilePath 'C:\Program Files\GitHub CLI\gh.exe' -ArgumentList 'auth login --hostname github.com --git-protocol https' -RedirectStandardOutput 'C:\Users\mz\AppData\Local\Temp\gh_auth_log.txt' -RedirectStandardError 'C:\Users\mz\AppData\Local\Temp\gh_auth_err.txt' -PassThru
Start-Sleep -Seconds 8
if (Test-Path 'C:\Users\mz\AppData\Local\Temp\gh_auth_err.txt') {
    Write-Output "===ERR==="
    Get-Content 'C:\Users\mz\AppData\Local\Temp\gh_auth_err.txt'
}
if (Test-Path 'C:\Users\mz\AppData\Local\Temp\gh_auth_log.txt') {
    Write-Output "===OUT==="
    Get-Content 'C:\Users\mz\AppData\Local\Temp\gh_auth_log.txt'
}
Write-Output "===PID===$($proc.Id)"
$proc.WaitForExit()
Write-Output "===EXIT===$($proc.ExitCode)"
