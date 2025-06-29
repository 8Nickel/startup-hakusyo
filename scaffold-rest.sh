#!/usr/bin/env bash
set -e
git checkout -b feature/add-rest-categories

cats=(
  "founders-insight"
  "trends"
  "failures"
  "vc-interviews"
  "glossary"
  "news"
)

today=$(date +%Y-%m-%d)

to_title() { echo "$1" | tr '-/' ' ' | sed -E 's/(^| )([a-z])/\1\u\2/g'; }

for c in "${cats[@]}"; do
  mkdir -p "src/content/$c"
  cat > "src/content/$c/sample.md" <<EOF
---
title: "Sample $(to_title "$c")"
date: "$today"
tags: ["sample"]
excerpt: "ダミー記事です。"
---

**このページは雛形です。**
EOF

  mkdir -p "src/pages/$c"
  case $c in
    founders-insight) title="起業家分析" ;;
    trends)           title="最新トレンド・マーケットデータ" ;;
    failures)         title="経営失敗談" ;;
    vc-interviews)    title="VC インタビュー" ;;
    glossary)         title="用語集" ;;
    news)             title="ニュース" ;;
  esac

  cat > "src/pages/$c/index.astro" <<EOF
---
import { getCollection } from 'astro:content';
const posts = await getCollection('$c');
---
<h1>$title</h1>
<ul>
  {posts.map((p) => (
    <li><a href="/$c/{p.slug}/">{p.data.title}</a></li>
  ))}
</ul>
EOF
done

nav="src/components/NavBar.astro"
if [[ -f $nav ]]; then
  for c in "${cats[@]}"; do
    case $c in
      founders-insight) label="起業家分析" ;;
      trends)           label="トレンド" ;;
      failures)         label="失敗談" ;;
      vc-interviews)    label="VC インタビュー" ;;
      glossary)         label="用語集" ;;
      news)             label="ニュース" ;;
    esac
    echo "  <a href='/$c/'>$label</a>" >> "$nav"
  done
fi

git add src/pages src/content "$nav"
git commit -m "feat: add six categories with list pages and sample content"
git push -u origin feature/add-rest-categories

echo "✅ 6 カテゴリを追加して push 済み — GitHub で PR を作成してください。"
