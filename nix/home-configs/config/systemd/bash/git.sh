#!/bin/sh

cd /home/alloar/Documents/Obsidian\ Vault/

git add .

git commit -m "$(date '+%Y-%n-%d %H:%M:%S')"

git push origin main
