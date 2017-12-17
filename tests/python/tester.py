# Tester file
import numpy as np
import h5py
import time

from options import *
from test import *

## Testing

results = np.zeros(number_of_tests)

input_data = prepare_input(10**input_size)
output_data = test_function(input_data)

for i in range(0,number_of_tests):
    tic = time.time()
    output_data = test_function(input_data)
    results[i] = time.time() - tic

f = h5py.File("/tmp/results.h5", "a")
dataset = test_name + "/python/" + str(input_size)

if dataset in f.keys():
    del f[dataset]

f.create_dataset(dataset, data=results)
f.close()
