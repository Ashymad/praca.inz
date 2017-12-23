# wavread test

using WAV

Fs = 48000;

function prepare_input(input_size)
	t = (0:input_size-1)/Fs;
	y = 0.7*sin.(2*pi*50*t) + sin.(2*pi*120*t) + 2*randn(size(t));
	filename = "/home/shyman/tmp/audiofile.wav";
	wavwrite(y/maximum(abs.(y)), filename, Fs=Fs);
	return filename
end

function test_function(input_data)
	y, Fs = wavread(input_data);
	return y
end
