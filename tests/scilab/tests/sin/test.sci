// Sinus test

function input_data = prepare_input(input_size)
	input_data = linspace(0, 2*%pi, input_size);
end

function test_function(input_data)
	y = sin(input_data);
end
