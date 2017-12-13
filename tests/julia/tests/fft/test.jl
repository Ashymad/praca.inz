# FFT test

Fs = 1000;            # Sampling frequency                    
T = 1/Fs;             # Sampling period       

FFTW.set_num_threads(Sys.CPU_CORES)

function prepare_input(input_size)
	t = (0:input_size-1)*T;        # Time vector

	S = 0.7*sin.(2pi*50t) + sin.(2pi*120t);
	return S + 2*randn(size(t));
end


function test_function(input_data)
	Y = fft(input_data)
	return
end
