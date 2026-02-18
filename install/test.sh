#!/usr/bin/env bash
parted -lm | awk -F: '$1=="/dev/sda" {print NR, $1 }'
