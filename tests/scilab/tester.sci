// Tester file

exec("options.sci");
exec("test.sci");

//// Testing
results = zeros(1, number_of_tests); 

input_data = prepare_input(10^input_size);
output_data = test_function(input_data); // First test is skipped to account for compilation

for i = 1:number_of_tests
	tic();
	output_data = test_function(input_data);
	results(i) = toc();
end

// Saving to filr
file = '/tmp/results.h5';
software = 'scilab'
dataset = strcat(['/' test_name '/' software '/' string(input_size)]);

f = h5open(file, "a");
if h5exists(f, dataset) then
	h5rm(f, dataset);
end
if ~h5exists(f, test_name) then
	h5group(f, test_name);
end
if ~h5exists(f, strcat([test_name '/' software])) then
	h5group(f, strcat([test_name '/' software]));
end
h5write(f, dataset, results);
h5close(f);

quit()
