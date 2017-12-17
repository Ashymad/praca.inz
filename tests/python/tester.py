# Tester file
import numpy as np
import h5py
import time

from options import *
from test import *

## Testing

results = np.zeros((max_input_size, number_of_tests))

for input_size in range(0, max_input_size):
    input_data = prepare_input(10**(input_size+1))
    output_data = test_function(input_data)

    for i in range(0,number_of_tests):
        tic = time.time()
        output_data = test_function(input_data)
        results[input_size, i] = time.time() - tic

f = h5py.File("/tmp/results.h5", "a")
dataset = test_name + "/python"

if dataset in f.keys():
    del f[dataset]

f.create_dataset(dataset, data=results)
f.close()
