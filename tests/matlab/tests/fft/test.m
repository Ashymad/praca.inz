% FFT test

Fs = 1000;
T = 1/Fs;

prepare_input = @(input_size) prepare_input_(input_size, T);
test_function = @(input_data) test_function_(input_data);

function input_data = prepare_input_(input_size, T)
	t = (0:input_size-1)*T;
	S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
	input_data = S + 2*randn(size(t));
end

function output_data = test_function_(input_data)
	output_data = fft(input_data);
end
