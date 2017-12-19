%pass test

prepare_input = @(input_size) prepare_input_(input_size);
test_function = @(input_data) test_function_(input_data);

function input_data = prepare_input_(input_size)
	input_data = zeros(input_size,1);
end

function output_data = test_function_(input_data)
	output_data = input_data;
end
