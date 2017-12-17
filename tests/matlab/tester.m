% Tester file

options;
test;

%% Testing

results = zeros(number_of_tests, 1); 

input_data = prepare_input(10^input_size);
output_data = test_function(input_data); % First test is skipped to account for compilation

for i = 1:number_of_tests
	tic();
	output_data = test_function(input_data);
	results(i) = toc();
end

file = '/tmp/results.h5';
dataset = ['/' char(test_name) '/matlab/' num2str(input_size)];

fid = H5F.open(file, 'H5F_ACC_RDWR', 'H5P_DEFAULT');
if H5L.exists(fid, ['/' char(test_name)], 'H5P_DEFAULT') 
	if H5L.exists(fid, ['/' char(test_name) '/matlab'], 'H5P_DEFAULT') 
		if H5L.exists(fid, dataset, 'H5P_DEFAULT')
			H5L.delete(fid, dataset, 'H5P_DEFAULT');
		end
	end
end
H5F.close(fid);

h5create(file, dataset, number_of_tests);
h5write(file, dataset, results);

exit
