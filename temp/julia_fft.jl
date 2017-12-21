function four1(data::Array{Float64,1}, isign::Int64)
    n::Int64 = length(data)
    nn::Int64 = n/2
    j::Int64 = 1;
    for i = 1:2:n
        if j > i
            tempr = data[j]; data[j] = data[i]; data[i] = tempr
            tempr = data[j+1]; data[j+1] = data[i+1]; data[i+1] = tempr
        end
        m=nn;
        while m >= 2 && j > m
            j -= m;
            m = m/2;
        end
        j += m;
    end
    mmax=2;
    while n > mmax
        istep=mmax*2;
        theta=isign*(2*pi/mmax);
        wtemp=sin(0.5*theta);
        wpr = -2.0*wtemp*wtemp;
        wpi=sin(theta);
        wr=1.0;
        wi=0.0;

        for m = 1:2:mmax
            for i=m:istep:n
                j=i+mmax;
                tempr=wr*data[j]-wi*data[j+1];
                tempi=wr*data[j+1]+wi*data[j];
                data[j]=data[i]-tempr;
                data[j+1]=data[i+1]-tempi;
                data[i] += tempr;
                data[i+1] += tempi;
            end
            wr=(wtemp=wr)*wpr-wi*wpi+wr;
            wi=wi*wpr+wtemp*wpi+wi;
        end
        mmax=istep;
    end
end

input_size = 1024;
Fs = 1000
T = 1/Fs;             # Sampling period       
X = zeros(input_size);
Y = zeros(input_size);
    
for i = 1:2:input_size
    t = T*(i-1)/2;
    X[i] = 0.7*sin(2.0*pi*50.0*t) + sin(2.0*pi*120.0*t);
    X[i+1] = 0;
    Y[i+1] = X[i+1];
    Y[i] = X[i];
end

four1(Y, 1);

for i = 1:2:input_size
    @printf("%f + %fi\t->\t%f + %fi\n", X[i], X[i+1], Y[i], -Y[i+1]);
end
