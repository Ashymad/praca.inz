# Tester file

include("options.jl");
include("test.jl");

## Testing

results = Array{Float64}(number_of_tests, max_input_size);

for input_size = 1:max_input_size
	input_data = prepare_input(10^input_size)
	test_function(input_data)
	for i = 1:number_of_tests
		tic();
		test_function(input_data);
		results[i, input_size] = toq();
	end
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
