% Sinus test

test_name = 'sin';
number_of_tests = 10;

x = 0:0.0000001:2*pi;

test_function = @() t(x);
function t(x)
	y = sin(x);
end



