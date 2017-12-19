# Sinus test

import math as m
import numpy as np
import numexpr as ne

def prepare_input(input_size):
    return np.linspace(0,2*m.pi,input_size)

def test_function(input_data):
    return ne.evaluate("sin(input_data)")

