function four1(data::Array{Complex{Float64},1}, isign::Int64)
    nn::Int64 = length(data)
    n::Int64 = nn*2
    j::Int64 = 1;
    for i = 1:nn
        if j > i
            tempr = data[j]; data[j] = data[i]; data[i] = tempr
        end
        m::Int64 = nn/2;
        while m >= 2 && j > m
            j -= m;
            m = m/2;
        end
        j += m;
    end
    mmax=2;
    while n > mmax
        istep=2*mmax;
        theta=isign*(2*pi/mmax);
        wtemp=sin(0.5*theta);
        wpr = -2.0*wtemp*wtemp;
        wpi=sin(theta);
        wr=1.0;
        wi=0.0;

        for m = 1:2:(mmax-1)
            for i=m:istep:n
                j=i+mmax;
                w = wr + wi*im
                temp = w*data[div(j+1,2)]
                data[div(j+1,2)] = data[div(i+1,2)] - temp;
                data[div(i+1,2)] += temp;
            end
            wtemp=wr
            wr=wtemp*wpr-wi*wpi+wr;
            wi=wi*wpr+wtemp*wpi+wi;
        end
        mmax=istep;
    end
end

input_size = 512;
Fs = 1000
T = 1/Fs;             # Sampling period       
X = zeros(input_size) + 0im;
Y = zeros(input_size) + 0im;
    
for i = 1:input_size
    t = T*(i-1);
    X[i] = 0.7*sin(2.0*pi*50.0*t) + sin(2.0*pi*120.0*t);
    Y[i] = X[i];
end

four1(Y, 1);
