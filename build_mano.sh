#!/bin/bash
mano=${1:-'x'}

source ./setflenv.sh

echo "fl2eps"
fl2eps.sh ${mano}

echo "xtxtfl2h"
xtxtfl2h.sh ${mano}

echo "xsynfl2h"
xsynfl2h.sh ${mano}

