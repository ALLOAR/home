#!/usr/bin/env bash

set -e

DIR="/home/alloar/nix/"
MSG="${1:-auto: $(date '+%Y-%m-%d %H:%M:%S')}"

cd "$DIR" || { echo "❌ Директория не найдена: $DIR"; exit 1; }

git add .
git commit -m "$MSG" || echo "⚠️  Нет изменений для коммита"
git push

echo "✅ Отправлено: $DIR @ $MSG"
