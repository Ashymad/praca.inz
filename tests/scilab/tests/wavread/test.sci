// wavread test

Fs = 48000;

function input_data = prepare_input(input_size)
	t = (0:input_size-1)/Fs;
	y = 0.7*sin(2*%pi*50*t) + sin(2*%pi*120*t) + 2*rand(t,'normal');
	input_data = '/home/shyman/tmp/audiofile.wav';
	wavwrite(y/max(abs(y)), Fs, input_data);
end

function output_data = test_function(input_data)
	output_data = wavread(input_data);
end
