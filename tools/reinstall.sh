#!/bin/sh

# Define root of project.
cd ${0%/*}
ROOT=$(dirname $(pwd))
cd ${ROOT}

rm -rfv builds/*
rm -rfv repository/*
vagrant destroy

sh ${ROOT}/tools/install.sh
