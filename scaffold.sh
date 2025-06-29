#!/usr/bin/env bash
set -e  # エラーで停止

### 0) ブランチを作成
git checkout -b feature/scaffold-content

### 1) コンテンツ用ディレクトリを作成
dirs=(
  "interviews"
  "founders-insight"
  "trends"
  "failures"
  "vc-interviews"
  "glossary"
  "news"
)

for d in "${dirs[@]}"; do
  mkdir -p "src/content/${d}"
done

### 2) 各ディレクトリにダミー Markdown を配置
today=$(date +%Y-%m-%d)
for d in "${dirs[@]}"; do
cat > "src/content/${d}/sample-${d}.md" <<EOF
---
title: "Sample ${d^} Article"
date: "${today}"
tags: ["sample"]
excerpt: "${d^} 初期コンテンツのダミーです。"
---

**このページは雛形です。**  
本番記事に差し替えるまで Vercel プレビューでページ構造を確認する用途に使います。
EOF
done

### 3) （任意）NavBar にメニューリンクを追加する TODO コメントを挿入
# 既存の NavBar.astro がない場合はスキップ
if [ -f "src/components/NavBar.astro" ]; then
  echo -e "\n<!-- TODO: 自動生成された 7 メニューを追加してください -->" >> src/components/NavBar.astro
fi

### 4) 変更をステージしてコミット
git add src/content src/components/NavBar.astro 2>/dev/null || true
git commit -m "Scaffold content directories & dummy articles"

### 5) GitHub に Push
git push -u origin feature/scaffold-content

echo "✅ すべて完了！  Pull Request を作成し、Vercel プレビューで確認してください。"
