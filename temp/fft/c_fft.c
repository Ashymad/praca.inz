#include <math.h>
#include <stdio.h>
#define SWAP(a,b) tempr=(a);(a)=(b);(b)=tempr
#define INPUT_SIZE 1024
#define PI 3.14159265358979323846264338

void four1(float data[], unsigned long nn, int isign) {
	unsigned long n,mmax,m,j,istep,i;
	double wtemp,wr,wpr,wpi,wi,theta;
	float tempr,tempi;
	n=nn << 1;
	j=1;
	for (i=1;i<n;i+=2) {
		if (j > i) {
			SWAP(data[j],data[i]);
			SWAP(data[j+1],data[i+1]);
		}
		m=nn;
		while (m >= 2 && j > m) {
			j -= m;
			m >>= 1;
		}
		j += m;
	}
	mmax=2;
	while (n > mmax) {
		istep=mmax << 1;
		theta=isign*(2*PI/mmax);
		wtemp=sin(0.5*theta);
		wpr = -2.0*wtemp*wtemp;
		wpi=sin(theta);
		wr=1.0;
		wi=0.0;
		for (m=1;m<mmax;m+=2) {
			for (i=m;i<=n;i+=istep) {
				j=i+mmax;
				tempr=wr*data[j]-wi*data[j+1];
				tempi=wr*data[j+1]+wi*data[j];
				data[j]=data[i]-tempr;
				data[j+1]=data[i+1]-tempi;
				data[i] += tempr;
				data[i+1] += tempi;
			}
			wr=(wtemp=wr)*wpr-wi*wpi+wr;
			wi=wi*wpr+wtemp*wpi+wi;
		}
		mmax=istep;
	}
}

int main() {
	int Fs = 1000;            // Sampling frequency                    
	float T = 1.0f/Fs;             // Sampling period       
	float X[INPUT_SIZE];
	float Y[INPUT_SIZE];

	for (int i = 1; i < INPUT_SIZE; i += 2) {
		float t = T*(i-1)/2;
		X[i-1] = 0.7f*sin(2.0f*PI*50.0f*t) + sin(2.0f*PI*120.0f*t);
		X[i] = 0;
		Y[i] = X[i];
		Y[i-1] = X[i-1];
	}

	four1(Y-1, INPUT_SIZE/2, 1);

	for (int i = 1; i < INPUT_SIZE; i+=2) {
		printf("%f + %fi\t->\t%f + %fi\n", X[i-1], X[i], Y[i-1], -Y[i]);
	}

	return 0;
}
