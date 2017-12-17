// Sinus test

function input_data = prepare_input(input_size)
	input_data = linspace(0, 2*%pi, input_size);
end

function output_data = test_function(input_data)
	output_data = sin(input_data);
end
