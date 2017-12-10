% Tester file

format long;
test;

%% Testing
% Skip the first test
test_function();

results = zeros(number_of_tests,1); 

for i = 1:number_of_tests
	tic();
	test_function();
	results(i) = toc();
end

pkg load hdf5oct;
file = '/tmp/results.h5';
dataset = ['/' test_name '/octave'];

h5delete(file, dataset);
h5create(file, dataset, number_of_tests);
h5write(file, dataset, results);
