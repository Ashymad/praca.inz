// FFT test

Fs = 1000;            // Sampling frequency                    
T = 1/Fs;             // Sampling period       

function input_data = prepare_input(input_size)
	t = (0:input_size-1)*T;        // Time vector
	S = 0.7*sin(2*%pi*50*t) + sin(2*%pi*120*t);
	input_data = S + 2*rand(t,'normal');
end

function test_function(input_data)
	Y = fft(input_data);
end
