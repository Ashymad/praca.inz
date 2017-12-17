#!/bin/bash

# Binaries
JULIA="/opt/juliapro/JuliaPro-0.6.1.1/julia"
MATLAB="/opt/MATLAB/R2017b/bin/matlab"
SCILAB="/opt/Scilab/scilab-branch-6.0-linux-x86_64/bin/scilab-cli"
OCTAVE="/usr/bin/octave"
ANACONDA="/opt/anaconda/bin/activate"

STARTDIR="$(pwd)"
TESTARG="$2"

# Global options
NUMBER_OF_TESTS=100
INPUT_SIZES=$(seq 1 7) # In powers of ten, e.g. 7 means max input vector lenght is 10^7

GOPTIONS=("number_of_tests=$NUMBER_OF_TESTS") 

! [ -f results.h5 ] && h5mkgrp results.h5 "/" 2>/dev/null
cp results.h5 /tmp

testdir () {
	cd $STARTDIR/$3

	for option in ${GOPTIONS[*]}; do
		echo "$option;" >> options.$2
	done
	
	for dir in tests/*; do
		cd $STARTDIR/$3
		TESTNAME=$(echo $dir | cut -c 7-)
		if [[ "$TESTARG" != "" ]] && [[ "$TESTNAME" != "$TESTARG" ]]
			then continue
		fi
		echo "Test: $TESTNAME..."
		cp options.$2 $dir
		cp tester.$2 $dir
		cd $dir
		printf 'test_name="%s";\n' "$TESTNAME" >> options.$2
		for input_size in $INPUT_SIZES; do
			printf 'input_size=%s;\n' $input_size >> options.$2
			$STARTDIR/rt.sh $1
		done
		rm tester.$2
		rm options.$2
	done
	
	cd $STARTDIR/$3
	rm options.$2
	cd $STARTDIR
}

# Julia
testjulia () {
	echo "Testing Julia..."
	testdir "$JULIA tester.jl" jl julia
}

# Octave
testoctave () {
	echo "Testing GNU Octave..."
	testdir "$OCTAVE tester.m" m octave
}

# MATLAB
testmatlab () {
	echo "Testing MATLAB..."
	testdir "$MATLAB -nodisplay -nosplash -nodesktop -nojvm -r tester" m matlab
}

# Anaconda
testpython () {
	echo "Testing Anaconda..."
	source $ANACONDA
	testdir "python tester.py" py python
}


# Scilab
testscilab () {
	echo "Testing Scilab..."
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
