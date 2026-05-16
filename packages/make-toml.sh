#!/bin/bash

REQ_FILE="../requirements.txt"
OUTPUT_FILE="pyproject.toml"

# 1. requirements.txt の存在確認
if [ ! -f "$REQ_FILE" ]; then
    echo "Error: $REQ_FILE が見つかりません。"
    exit 1
fi

# 2. 依存関係をTOML形式のリストに整形
# - コメントと空行を除去
# - 各行をダブルクォーテーションで囲み、末尾にカンマを追加
DEPS=$(grep -v '^\s*#' "$REQ_FILE" | grep -v '^\s*$' | sed 's/.*/    "&",/')

# 3. ヒアドキュメントで pyproject.toml を生成
cat <<EOF > "$OUTPUT_FILE"
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "packages"
version = "0.1.0"
readme = "README.md"
requires-python = ">=3.8"
dependencies = [
${DEPS%,}
]

[tool.setuptools.packages.find]
where = ["src"]
EOF

echo "Success: $OUTPUT_FILE を作成しました。"