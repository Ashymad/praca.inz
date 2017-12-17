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

pkg load hdf5oct;
file = '/tmp/results.h5';
dataset = ['/' test_name '/octave/' num2str(input_size)];

try
	h5delete(file, dataset);
catch exception
	h5create(file, dataset, number_of_tests);
end

h5write(file, dataset, results);
