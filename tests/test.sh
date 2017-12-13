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
GOPTIONS=('number_of_tests=40'
	  'max_input_size=7') # In powers of ten, e.g. 7 means max input vector lenght is 10^7

[ -f results.h5 ] && cp results.h5 /tmp

function testdir {
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
	echo "Testing Julia..."
	testdir "$JULIA tester.jl" jl julia
}

# Octave
function testoctave {
	echo "Testing GNU Octave..."
	testdir "$OCTAVE tester.m" m octave
}

# MATLAB
function testmatlab {
	echo "Testing MATLAB..."
	testdir "$MATLAB -nodisplay -nosplash -nodesktop -nojvm -r tester" m matlab
}

# Anaconda
function testpython {
	echo "Testing Anaconda..."
	source $ANACONDA
	testdir "python tester.py" py python
}


# Scilab
function testscilab {
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
