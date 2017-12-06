#!/bin/sh


# Binaries
JULIA="/opt/juliapro/JuliaPro-0.6.1.1/julia"
MATLAB="/opt/MATLAB/R2017b/bin/matlab"
SCILAB="/opt/Scilab/scilab-branch-6.0-linux-x86_64/bin/scilab-cli"
OCTAVE="/usr/bin/octave"
ANACONDA="/opt/anaconda/bin/activate"

STARTDIR=$(pwd)

function testdir {
	for dir in tests/*; do
		cp tester.* $dir
		cd $dir
		$STARTDIR/rt.sh $1
		rm tester.*
		cd $STARTDIR
	done
}

# Julia
function testjulia {
	cd julia
	testdir "$JULIA tester.jl"
}

# Octave
function testoctave {
	cd octave
	testdir "$OCTAVE tester.m"
}

# MATLAB
function testmatlab {
	cd matlab
	testdir "$MATLAB -nodisplay -nosplash -nodesktop -r tester"
}

case $1 in
	julia)
		testjulia
		;;
	octave)
		testoctave
		;;
	matlab)
		testmatlab
		;;
	*)
		testjulia
		testoctave
		testmatlab
		;;
esac

