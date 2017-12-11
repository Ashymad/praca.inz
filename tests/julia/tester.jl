# Tester file

include("options.jl");
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

file = "/tmp/results.h5";
dataset = "$test_name/julia";

h5open(file, "r+") do fid
	if exists(fid, dataset);
		o_delete(fid, dataset);
	end
	fid[dataset] = results;
end
