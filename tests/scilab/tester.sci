// Tester file

exec("options.sci");
exec("test.sci");

//// Testing
results = zeros(number_of_tests, max_input_size); 

for input_size = 1:max_input_size
	input_data = prepare_input(10^input_size);
	test_function(input_data); // First test is skipped to account for compilation

	for i = 1:number_of_tests
		tic();
		test_function(input_data);
		results(i, input_size) = toc();
	end
end

// Saving to filr
file = '/tmp/results.h5';
dataset = strcat([test_name '/scilab']);

f = h5open(file, "a");
if h5exists(f, dataset) then
	h5rm(f, dataset);
end
h5write(f, dataset, results);
h5close(f);

quit()
