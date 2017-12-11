// Sinus test

test_name = "sin";
number_of_tests = 100;

x = 0:0.0000001:2*%pi;

function test_function()
	y = sin(x);
endfunction

