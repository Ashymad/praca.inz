# Tester file
import numpy as np
import h5py
import time

from options import *
from test import *

## Testing
# Skip the first test
test_function()

results = np.zeros(number_of_tests)

for i in range(0,number_of_tests):
    tic = time.time()
    test_function()
    results[i] = time.time() - tic

f = h5py.File("/tmp/results.h5", "a")
dataset = test_name + "/python"

if dataset in f.keys():
    del f[dataset]

f.create_dataset(dataset, data=results)
f.close()
