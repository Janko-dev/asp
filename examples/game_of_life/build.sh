#!/bin/bash

N="$1";

OUTPUT_JSON="out_grid.json"
OUT_GRID="out_grid.lp"
OUT_GRID_TMP="out_grid_temp.lp"

GRID_ALGO="gen_grid.lp"
GOL_ALGO="gol.lp"

cd "$(dirname "$0")"

clingo $GRID_ALGO 0 -V0 --out-atomf=%s. | head -n 1 > $OUT_GRID

for (( c=1; c<=$N; c++ ))
do    
    clingo $GOL_ALGO $OUT_GRID 0 --outf=2 > $OUTPUT_JSON

    clingo $GOL_ALGO $OUT_GRID 0 -V0 --out-atomf=old_%s. | head -n 1 > $OUT_GRID_TMP

    python vis.py $OUTPUT_JSON

    cp $OUT_GRID_TMP $OUT_GRID
done

