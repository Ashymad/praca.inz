# Sinus test

function prepare_input(input_size)
	return linspace(0, 2pi, input_size)
end

function test_function(input_data)
	return sin.(input_data)
end
