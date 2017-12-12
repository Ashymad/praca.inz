# FFT test

Fs = 1000;            # Sampling frequency                    
T = 1/Fs;             # Sampling period       
L = 16000000;         # Length of signal
t = (0:L-1)*T;        # Time vector

S = 0.7*sin.(2pi*50t) + sin.(2pi*120t);
X = S + 2*randn(size(t));

FFTW.set_num_threads(Sys.CPU_CORES)

function test_function()
	Y = fft(X)
end
