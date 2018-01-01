function Y = fftconv(X1, X2)
	pad1 = zeros(1, length(X2) - 1);
	pad2 = zeros(1, length(X1) - 1);
	Y = abs(ifft(fft([X1 pad1]).*fft([X2 pad2])));
end
