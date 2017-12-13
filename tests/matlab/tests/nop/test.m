%nop test

prepare_input = @(input_size) prepare_input_(input_size);
test_function = @(input_data) test_function_();

function input_data = prepare_input_(input_size)
	input_data = zeros(input_size,1);
end

function test_function_(input_data)
	
end
