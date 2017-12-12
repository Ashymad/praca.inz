% FFT test

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 16000000;         % Length of signal
t = (0:L-1)*T;        % Time vector

S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
X = S + 2*randn(size(t));

test_function = @() test_function_(X);
function test_function_(X)
	Y = fft(X);
end
