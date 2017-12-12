% Sinus test

x = 0:0.0000001:2*pi;

test_function = @() test_function_(x);
function test_function_(x)
	y = sin(x);
end
