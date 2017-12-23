% wavread test

Fs = 48000;

prepare_input = @(input_size) prepare_input_(input_size, Fs);
test_function = @(input_data) test_function_(input_data);

function input_data = prepare_input_(input_size, Fs)
	t = (0:input_size-1)/Fs;
	y = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t) + 2*randn(size(t));
	input_data = '/home/shyman/tmp/audiofile.wav';
	audiowrite(input_data, y/max(abs(y)), Fs);
end

function output_data = test_function_(input_data)
	[output_data, Fs] = audioread(input_data);
end
