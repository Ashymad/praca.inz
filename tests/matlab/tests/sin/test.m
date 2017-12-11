% Sinus test

x = 0:0.0000001:2*pi;

test_function = @() t(x);
function t(x)
	y = sin(x);
end



