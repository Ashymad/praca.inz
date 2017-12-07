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

file = '/tmp/results.h5';
dset = ['/' testname '/octave'];

fid = H5F.open(file, 'H5F_ACC_RDWR', 'H5P_DEFAULT');
H5L.delete(fid, dset, 'H5P_DEFAULT');
H5F.close(fid);

h5create(file, dset, number_of_tests);
h5write(file, dset, results);

exit
