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

h5create('/tmp/results.h5', ['/' testname '/matlab'], [number_of_tests 1]);
h5write('/tmp/results.h5', ['/' testname '/matlab'], results);

exit
