#!/bin/bash

OUTPUT="out.json"
INPUT="grid.lp"

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

clingo $INPUT 0 --outf=2 > $OUTPUT

python vis.py $OUTPUT