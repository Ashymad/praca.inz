# Tester file

include("prepare.jl");
include("test.jl");

## Testing
# Skip the first test
test();
results = Array{Float64}(number_of_tests);

for i = 1:number_of_tests
	tic();
	test();
	results[i] = toq();
end

using HDF5
h5write("/tmp/results.h5", "$testname/julia", results);
