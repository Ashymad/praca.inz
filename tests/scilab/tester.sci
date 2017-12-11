// Tester file

exec("options.sci");
exec("test.sci");

//// Testing
// Skip the first test
test_function();
results = zeros(number_of_tests,1); 

for i = 1:number_of_tests
	tic();
	test_function();
	results(i) = toc();
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
