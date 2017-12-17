# Tester file

include("options.jl");
include("test.jl");

## Testing

results = zeros(number_of_tests);

input_data = prepare_input(10^input_size)
output_data = test_function(input_data)

for i = 1:number_of_tests
	tic();
	output_data = test_function(input_data);
	results[i] = toq();
end

# Saving to file
using HDF5

file = "/tmp/results.h5";
dataset = "$test_name/julia/$input_size";

h5open(file, "r+") do fid
	if exists(fid, dataset);
		o_delete(fid, dataset);
	end
	fid[dataset] = results;
end
