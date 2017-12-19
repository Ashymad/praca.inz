// pass test

function input_data = prepare_input(input_size)
	input_data = {rand(input_size,1),rand(input_size,1)}
end

function output_data = test_function(input_data)
	output_data = conv(input_data{1}, input_data{2})
end
