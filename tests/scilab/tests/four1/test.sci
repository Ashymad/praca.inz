// four1 test

Fs = 1000;            // Sampling frequency                    
T = 1/Fs;             // Sampling period       

function input_data = prepare_input(input_size)
	t = (0:input_size-1)*T;        // Time vector
	S = zeros(1,2^ceil(log2(input_size)));
	S(1:input_size) = 0.7*sin(2*%pi*50*t) + sin(2*%pi*120*t) + 2*rand(t,'normal');
	input_data = S 
end

function output_data = test_function(input_data)
    isign = 1
    nn = length(input_data);
    nnlog = log2(nn);
    if ceil(nnlog) ~= nnlog
	    error("Length of input_data vector must be a power of 2.");
    end
    j = 1;
    output_data = input_data + 0*%i;

    for i = 1:nn
        if j > i
            [output_data(j), output_data(i)] = (input_data(i), input_data(j));
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
        theta = isign*(%pi/mmax);
        wp = -2*sin(theta/2)^2 + sin(theta)*%i;
        w = 1 + 0*%i;

        for m = 1:mmax
            for i = m:istep:nn
                j = i + mmax;
                temp = w*output_data(j);
                output_data(j) = output_data(i) - temp;
                output_data(i) = output_data(i) + temp;
            end
            w = w + w*wp;
        end
        mmax = istep;
    end
end
