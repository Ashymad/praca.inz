# FFT test
import numpy as np
import math as m

Fs = 1000            # Sampling frequency                    
T = 1/Fs             # Sampling period       

def prepare_input(input_size):
    t = np.arange(0,input_size)*T        # Time vector

    S = 0.7*np.sin(2*m.pi*50*t) + np.sin(2*m.pi*120*t)
    return S + 2*np.random.randn(np.size(t))


def test_function(input_data):
    return np.fft.fft(input_data)
