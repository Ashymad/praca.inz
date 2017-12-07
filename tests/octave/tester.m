% Tester file

format long;
prepare

%% Testing
% Skip the first test
test;
results = zeros(number_of_tests,1); 

for i = 1:number_of_tests
	tic();
	test;
	results(i) = toc();
end

pkg load hdf5oct;
h5create('/tmp/results.h5', ['/' testname '/octave'], number_of_tests);
h5write('/tmp/results.h5', ['/' testname '/octave'], results);
