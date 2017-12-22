# four1 test
import numpy as np
import math as ma

Fs = 1000            # Sampling frequency                    
T = 1/Fs             # Sampling period       

def prepare_input(input_size):
    t = np.arange(0,input_size)*T        # Time vector
    S = np.zeros(2**ma.ceil(ma.log(input_size,2)))
    S[0:input_size] = 0.7*np.sin(2*ma.pi*50*t) + np.sin(2*ma.pi*120*t) + 2*np.random.randn(np.size(t))
    return S 


def test_function(input_data):
    isign = 1
    nn = len(input_data)
    nnlog = ma.log(nn,2)
    if np.ceil(nnlog) != nnlog:
        raise ValueError("Length of input_data vector must be a power of 2.")
    j = 1
    res = input_data + 0j

    for i in range(1,nn+1):
        if j > i:
            res[j-1], res[i-1] = input_data[i-1], input_data[j-1]
        m = nn//2
        while m >= 2 and j > m:
            j -= m
            m = m//2
        j += m

    mmax = 1
    while nn > mmax:
        istep = 2*mmax
        theta = isign*(ma.pi/mmax)
        wp = -2*np.sin(theta/2)**2 + np.sin(theta)*1j
        w = 1 + 0j

        for m in range(1,mmax+1):
            for i in range(m,nn,istep):
                j = i + mmax
                temp = w*res[j-1]
                res[j-1] = res[i-1] - temp
                res[i-1] += temp
            w += w*wp
        mmax = istep
    return res
