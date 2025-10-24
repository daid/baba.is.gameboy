#!/bin/sh

set -eu

NAME=BabaIsGameboy
python3 ../GB.HLA/main.py main.asm --output ${NAME}.gbc --symbols ${NAME}.sym
if [ -e bgb.exe ]; then
    `which wine` ./bgb.exe ${NAME}.gbc
fi
