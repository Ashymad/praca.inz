# conv test

function prepare_input(input_size)
	return (rand(input_size),rand(input_size))
end

function test_function(input_data)
	return conv(input_data[1], input_data[2])
end
