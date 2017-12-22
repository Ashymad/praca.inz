# four1 test

Fs = 1000;            # Sampling frequency                    
T = 1/Fs;             # Sampling period       

function prepare_input(input_size)
	t = (0:input_size-1)*T;        # Time vector
	S = zeros(2^ceil(log2(input_size)))
	S[1:input_size] = 0.7*sin.(2pi*50t) + sin.(2pi*120t) + 2*randn(size(t));
	return S
end

function test_function(input_data)
	isign = 1
	nn = length(input_data)
	nnlog = log2(nn)
	if ceil(nnlog) != nnlog
		error("Length of input_data vector must be a power of 2.")
	end
	j::Int64 = 1
	res::Array{Complex{Float64},1} = copy(input_data)

	for i = 1:nn
		if j > i
			res[j], res[i] = input_data[i], input_data[j]
		end
		m = nn/2
		while m >= 2 && j > m
			j -= m
			m = m/2
		end
		j += m
	end

	mmax = 1;
	while nn > mmax
		istep = 2*mmax
		theta = isign*(pi/mmax)
		wp = -2*sin(theta/2)^2 + sin(theta)*im
		w = 1 + 0im

		for m = 1:mmax
			for i = m:istep:nn
				j = i + mmax
				temp = w*res[j]
				res[j] = res[i] - temp
				res[i] += temp
			end
			w += w*wp
		end
		mmax = istep
	end

	return res
end
