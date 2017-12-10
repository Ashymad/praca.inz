# Sinus test

test_name = "sin";
number_of_tests = 10;

x = 0:0.0000001:2pi;

function test_function()
	y = sin.(x);
end
