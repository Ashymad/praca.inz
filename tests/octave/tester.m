% Tester file

options;
test;

%% Testing

results = zeros(number_of_tests, max_input_size); 

for input_size = 1:max_input_size
	input_data = prepare_input(10^input_size);
	output_data = test_function(input_data); % First test is skipped to account for compilation

	for i = 1:number_of_tests
		tic();
		output_data = test_function(input_data);
		results(i, input_size) = toc();
	end
end

pkg load hdf5oct;
file = '/tmp/results.h5';
dataset = ['/' test_name '/octave'];

try
	h5delete(file, dataset);
catch exception
	h5create(file, dataset, number_of_tests);
end

h5write(file, dataset, results);
