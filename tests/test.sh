#!/bin/bash

# Binaries
JULIA="/opt/juliapro/JuliaPro-0.6.1.1/julia"
MATLAB="/opt/MATLAB/R2017b/bin/matlab"
SCILAB="/opt/Scilab/scilab-branch-6.0-linux-x86_64/bin/scilab-cli"
OCTAVE="/usr/bin/octave"
ANACONDA="/opt/anaconda/bin/activate"

STARTDIR=$(pwd)

# Global options
GOPTIONS=('number_of_tests=10')

[ -f results.h5 ] && cp results.h5 /tmp

function testdir {
	cd $STARTDIR/$3

	for option in ${GOPTIONS[*]}; do
		echo "$option;" >> options.$2
	done

	for dir in tests/*; do
		cp options.$2 $dir
		cp tester.$2 $dir
		cd $dir
		printf 'test_name="%s";\n' $(echo $dir | cut -c 7-) >> options.$2
		$STARTDIR/rt.sh $1
		rm tester.$2
		rm options.$2
	done
	
	cd $STARTDIR/$3
	rm options.$2
	cd $STARTDIR
}

# Julia
function testjulia {
	testdir "$JULIA tester.jl" jl julia
}

# Octave
function testoctave {
	testdir "$OCTAVE tester.m" m octave
}

# MATLAB
function testmatlab {
	testdir "$MATLAB -nodisplay -nosplash -nodesktop -r tester" m matlab
}

# Anaconda
function testpython {
	source $ANACONDA
	testdir "python tester.py" py python
}


# Scilab
function testscilab {
	testdir "$SCILAB -f tester.sci" sci scilab
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
	python)
		testpython
		;;
	scilab)
		testscilab
		;;
	*)
		testjulia
		testoctave
		testmatlab
		testscilab
		testpython
		;;
esac

mv /tmp/results.h5 $STARTDIR
