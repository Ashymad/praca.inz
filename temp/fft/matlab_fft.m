input_size = 2048;
Fs = 1000;
T = 1/Fs;           % Sampling period 

t = T*(0:(input_size-1));
X = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

% Calling a function boefore its definition does not work in octave,
% but is required in MATLAB as function definitions must be _after_ 
% variable declarations. 
four1 = @(data, isign) four1_(data, isign); % This allows calling the function in repl

% Y = four1(X, 1); % Only possible in MATLAB

function res = four1_(data, isign)
	nn = length(data);
	nnlog = log2(nn);
	if ceil(nnlog) ~= nnlog
		error("Length of data vector must be a power of 2.");
	end
	j = 1;
	res = data + 0i;

	for i = 1:nn
		if j > i
			[res(j), res(i)] = deal(data(i), data(j));
		end
		m = nn/2;
		while m >= 2 && j > m
			j = j - m;
			m = m/2;
		end
		j = j + m;
	end

	mmax = 1;
	while nn > mmax
		istep = 2*mmax;
		theta = isign*(pi/mmax);
		wp = -2*sin(theta/2)^2 + sin(theta)*1i;
		w = 1 + 0i;

		for m = 1:mmax
			for i = m:istep:nn
				j = i + mmax;
				temp = w*res(j);
				res(j) = res(i) - temp;
				res(i) = res(i) + temp;
			end
			w = w + w*wp;
		end
		mmax = istep;
	end
end

% Y = four1(X, 1); % Only possible in octave
