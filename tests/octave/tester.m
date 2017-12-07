% Tester file

format long;
prepare

%% Testing
% Skip the first test
test;
results = zeros(number_of_tests,1); 

for i = 1:number_of_tests
	tic();
	test;
	results(i) = toc();
end

pkg load hdf5oct;
file = '/tmp/results.h5';
dset = ['/' testname '/octave'];

h5delete(file, dset);
h5create(file, dset, number_of_tests);
h5write(file, dset, results);
