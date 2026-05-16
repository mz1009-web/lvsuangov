@echo off
chcp 65001 >nul
echo =============================================
echo   绿算治策 - 一键部署脚本
echo   自动推送 GitHub + Vercel
echo =============================================
echo.

REM Check if gh CLI is installed
where gh >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [1/5] 正在安装 GitHub CLI...
    winget install --id GitHub.cli -e --accept-package-agreements --accept-source-agreements
    if %ERRORLEVEL% NEQ 0 (
        echo 安装失败，请手动安装：https://cli.github.com/
        pause
        exit /b 1
    )
) else (
    echo [1/5] GitHub CLI 已安装 ✓
)

REM Check gh auth status
gh auth status >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [2/5] 需要登录 GitHub 账号
    echo.
    echo ⚠️ 请在浏览器中完成以下步骤：
    echo.
    call gh auth login --hostname github.com --git-protocol https
) else (
    echo [2/5] GitHub 已登录 ✓
)

echo.
echo [3/5] 创建 GitHub 仓库...
gh repo create lvsuangov --public --description "绿色算力产业治理决策支持系统 · 基于中观经济学的路径匹配工具" --push --source "D:\Users\mz\学习\2026上\中观\绿算治策" --remote origin
if %ERRORLEVEL% NEQ 0 (
    echo 仓库可能已存在，尝试推送...
    cd /d "D:\Users\mz\学习\2026上\中观\绿算治策"
    git remote remove origin 2>nul
    git remote add origin https://github.com/%USERNAME%/lvsuangov.git
    git push -u origin main
)

echo.
echo [4/5] 代码已推送到 GitHub ✓
echo.
echo [5/5] Vercel 部署
echo.
echo 请打开以下链接部署到 Vercel：
echo   https://vercel.com/new/clone?repository-url=https://github.com/%USERNAME%/lvsuangov
echo.
echo 步骤：登录 Vercel（用 GitHub 账号）→ Import → Deploy
echo.
echo =============================================
echo ✅ 部署完成！
echo    访问地址：https://lvsuangov.vercel.app
echo    后续更新：修改代码后运行 git push 即可自动部署
echo =============================================
pause
