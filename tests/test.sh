#!/bin/sh


# Binaries
JULIA="/opt/juliapro/JuliaPro-0.6.1.1/julia"
MATLAB="/opt/MATLAB/R2017b/bin/matlab"
SCILAB="/opt/Scilab/scilab-branch-6.0-linux-x86_64/bin/scilab-cli"
OCTAVE="/usr/bin/octave"
ANACONDA="/opt/anaconda/bin/activate"

# Julia
cd julia
for dir in tests/*; do
	cp tester.jl $dir
	cd $dir
	$JULIA tester.jl
	rm tester.jl
	cd ../..
done

