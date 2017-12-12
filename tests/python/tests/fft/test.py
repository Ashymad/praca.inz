# FFT test
import numpy as np
import math as m

Fs = 1000            # Sampling frequency                    
T = 1/Fs             # Sampling period       
L = 16000000         # Length of signal
t = np.arange(0,L)*T        # Time vector

S = 0.7*np.sin(2*m.pi*50*t) + np.sin(2*m.pi*120*t);
X = S + 2*np.random.randn(np.size(t));

def test_function():
    Y = np.fft.fft(X)
    return
