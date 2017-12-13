% Tester file

options;
test;

%% Testing

results = zeros(number_of_tests, max_input_size); 

for input_size = 1:max_input_size
	input_data = prepare_input(10^input_size);
	test_function(input_data); % First test is skipped to account for compilation

	for i = 1:number_of_tests
		tic();
		test_function(input_data);
		results(i, input_size) = toc();
	end
end

file = '/tmp/results.h5';
dataset = ['/' char(test_name) '/matlab'];

fid = H5F.open(file, 'H5F_ACC_RDWR', 'H5P_DEFAULT');
if H5L.exists(fid, dataset, 'H5P_DEFAULT')
	H5L.delete(fid, dataset, 'H5P_DEFAULT');
end
H5F.close(fid);

h5create(file, dataset, [number_of_tests, max_input_size]);
h5write(file, dataset, results);

exit
