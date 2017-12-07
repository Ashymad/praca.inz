# Tester file
import numpy as np
import h5py
import time

from prepare import *
from test import *

## Testing
# Skip the first test
test()

results = np.zeros(number_of_tests)

for i in range(0,number_of_tests):
    tic = time.time()
    test()
    results[i] = time.time() - tic

f = h5py.File("/tmp/results.h5", "a")
dset = testname + "/python"

if dset in f.keys():
    del f[dset]

f.create_dataset(dset, data=results)
f.close()
