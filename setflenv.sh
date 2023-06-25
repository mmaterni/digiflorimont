#!/bin/bash

FLORI_DIR="/u/florix/flori"
export FLORI_DIR

SITE_DIR=`pwd`
export SITE_DIR

TEIM_DIR="/u/pyx/pyu/tei"
export TEIM_DIR

PT=''
PT=$PT:"${FLORI_DIR}/bin"
PT=$PT:"${SITE_DIR}/bin"

PT=$PT:"${TEIM_DIR}/bin"
PT=$PT:"${TEIM_DIR}/teimed"

PATH=$PATH:${PT}

. uniquepath

export PATH
