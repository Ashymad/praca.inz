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

save results.txt results -ascii
exit
