# Tester file

include("test.jl");

## Testing
# Skip the first test
test_function();

results = Array{Float64}(number_of_tests);

for i = 1:number_of_tests
	tic();
	test_function();
	results[i] = toq();
end

# Saving to file
using HDF5
h5write("/tmp/results.h5", "$test_name/julia", results);
