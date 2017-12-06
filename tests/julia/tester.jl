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
	result = toq();
	results[i] = result;
end

writedlm("results.txt", results, '\n');
