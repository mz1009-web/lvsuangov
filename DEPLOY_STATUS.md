# 绿算治策 · 部署已完成

---

## ✅ 已完成

| 项目 | 状态 | 说明 |
|------|------|------|
| A/B 标签删除 | ✅ | 输入参数区的 A/B 信用度标签已全部移除 |
| Git 仓库初始化 | ✅ | 分支 main，包含 index.html + 文档 |
| GitHub 仓库创建 | ✅ | https://github.com/mz1009-web/lvsuangov |
| 代码推送 | ✅ | 所有文件已推送到 GitHub |

## ⏳ 最后一步：Vercel 部署

1. 打开 https://vercel.com/new
2. 用 GitHub 账号登录（点 **Continue with GitHub**）
3. 在 Import 列表中找到 `mz1009-web/lvsuangov` → 点 **Import**
4. **Framework Preset** 选 **Other**，其余默认 → 点 **Deploy**
5. 等 30 秒，部署完成显示：

```
Congratulations!
https://lvsuangov.vercel.app
```

## 📌 免费域名

直接用 Vercel 自带的：
```
https://lvsuangov.vercel.app
```
国内可打开，无需购买域名。如果以后想绑定 `lvsuangov.cn`，在 Vercel 项目设置 → Domains 中添加即可（域名需另行购买，约 30-50 元/年）。

## 🔄 后续更新

以后修改代码后，在项目文件夹打开终端运行：

```bash
cd D:\Users\mz\学习\2026上\中观\绿算治策
git add index.html
git commit -m "更新内容说明"
git push
```

Vercel 自动检测到推送，1 分钟内自动重新部署。
