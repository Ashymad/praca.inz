#!/bin/sh

mkdir ./julia/tests/$1
cp ./julia/tests/pass/test.jl ./julia/tests/$1/test.jl
mkdir ./matlab/tests/$1
cp ./matlab/tests/pass/test.m ./matlab/tests/$1/test.m
mkdir ./octave/tests/$1
cd  ./octave/tests/$1
ln -s ../../../matlab/tests/$1/test.m
cd ../../..
mkdir ./python/tests/$1
cp ./python/tests/pass/test.py ./python/tests/$1/test.py
mkdir ./scilab/tests/$1
cp ./scilab/tests/pass/test.sci ./scilab/tests/$1/test.sci

