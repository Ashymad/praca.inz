# pass test
import numpy as np
import math as ma
from scipy.io import wavfile

Fs = 48000;

def prepare_input(input_size):
    t = np.arange(0,input_size)/Fs
    y = 0.7*np.sin(2*ma.pi*50*t) + np.sin(2*ma.pi*120*t) + 2*np.random.randn(np.size(t))
    filename = "/home/shyman/tmp/audiofile.wav"
    wavfile.write(filename, Fs, y)
    return filename

def test_function(input_data):
    Fs, y = wavfile.read(input_data)
    return y
