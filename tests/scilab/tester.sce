// Tester file

//format long;
exec("prepare.sce");
exec("test.sci");

//// Testing
// Skip the first test
test();
results = zeros(number_of_tests,1); 

for i = 1:number_of_tests
	tic();
	test;
	results(i) = toc();
end

file = '/tmp/results.h5';
dset = strcat([testname '/scilab']);

f = h5open(file, "a");
if h5exists(f, dset) then
	h5rm(f, dset);
end
h5write(f, dset, results);
h5close(f);

quit()
