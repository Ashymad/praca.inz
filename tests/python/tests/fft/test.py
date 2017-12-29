# FFT test
import numpy as np
from scipy import fftpack
import math as m

Fs = 1000
T = 1/Fs

def prepare_input(input_size):
    t = np.arange(0,input_size)*T

    S = 0.7*np.sin(2*m.pi*50*t) + np.sin(2*m.pi*120*t)
    return S + 2*np.random.randn(np.size(t))


def test_function(input_data):
    return fftpack.fft(input_data)
