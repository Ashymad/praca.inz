% Tester file

options;
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

file = '/tmp/results.h5';
dataset = ['/' char(test_name) '/matlab'];

fid = H5F.open(file, 'H5F_ACC_RDWR', 'H5P_DEFAULT');
H5L.delete(fid, dataset, 'H5P_DEFAULT');
H5F.close(fid);

h5create(file, dataset, number_of_tests);
h5write(file, dataset, results);

exit
