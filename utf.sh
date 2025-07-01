#!/usr/bin/env bash
set -e
echo "▼ 一括変換 (失敗したものだけスキップ)"
for f in src/content/**/*.md; do
  [ -f "$f" ] || continue
  echo -n "  $f ... "
  if iconv -f SHIFT_JIS -t UTF-8 "$f" -o "${f}.utf8" 2>/dev/null; then
    mv "${f}.utf8" "$f"
    echo "Converted"
  else
    rm -f "${f}.utf8"
    echo "Skipped (already UTF-8)"
  fi
done
echo "★ 変換完了"

echo "▼ Shift-JIS → UTF-8 変換完了"
