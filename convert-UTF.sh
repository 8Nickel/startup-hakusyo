#!/usr/bin/env bash
set -e

echo "▼ Shift-JIS → UTF-8 変換開始"
count=0

# 正しくワイルドカードを展開させる（ダブルクォートしない）
for f in src/content/**/*.md; do
  # ファイルが存在しないパターンはそのまま文字列になるのでスキップ
  [ -f "$f" ] || continue

  # iconv が「SHIFT_JIS → UTF-8」変換をエラーなく実行できたら
  if iconv -f SHIFT_JIS -t UTF-8 "$f" -o "${f}.utf8" 2>/dev/null; then
    mv "${f}.utf8" "$f"
    echo "  Converted: $f"
    count=$((count+1))
  fi
done

echo "★ $count ファイルを変換しました"
echo "▼ Shift-JIS → UTF-8 変換完了"