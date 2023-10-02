clear all; close all; clc;
R=mod(527*(2+0+1+7),4);


data = load(['ekg2.mat']);
x = data.ekg;
fs = data.fs;
t=0:1/fs:(length(x)-1)/fs;

N=2^nextpow2(length(x));
X=fft(x,N)/length(x);
X1=abs(X(1:N/2+1));
X1(2:N/2+1)=2*X1(2:N/2+1);
f1=0:fs/N:fs/2;

figure(1)
subplot(211)
    plot(t, x);
    xlabel('t[s]'); ylabel('x[t]');
    title('EKG'); grid on;
subplot(212)
    plot(f1,X1);
    xlabel('f[Hz]'); ylabel('|X(jf)|');
    title('Amplitudska karakteristika'); grid on;
   
Wp=[48 52]*2*pi;
Ws=[49 51]*2*pi;
Rp=2;
Rs=40;

[n,Ws]= cheb2ord(Wp, Ws, Rp, Rs, 's');
[b,a]=cheby2(n,Rs,Ws,'stop','s');

[h,w]=freqs(b,a,N/2+1);


fp=50;
[bz,az]=bilinear(b,a,fs,fp);
[hz,fz]=freqz(bz,az,N/2+1,fs);




figure(2)
    plot(w/(2*pi),20*log10(abs(h)),'k-'); hold on
    plot(fz,20*log10(abs(hz)),'r');
    xlabel('f[Hz]');
    title('Amplitudska karakteristika filtra'); grid on;
    legend('analogni','digitalni');
    
y = filter(bz, az, x); 

Y = fft(y,N)/length(y); 
Y1 = abs(Y(1:N/2+1));
Y1(2:N/2+1) = 2*Y1(2:N/2+1);   

figure(3)
    subplot(2, 2, [1, 3])
        plot(f1, X1, 'Linewidth', 1.5); hold on
        plot(f1, Y1, 'Linewidth', 1.5); 
        xlabel('f[Hz]'); ylabel('|X(jf)|, |Y(jf)|');
        legend('ulazni', 'izlazni signal')
        title('Amplitudske karakteristike ulaznog i izlaznog signala'); grid on;
    subplot(2, 2, 2)
        plot(t, x);
        xlabel('t[s]'); ylabel('x(t)');
        title('Ulazni signal'); grid on;
    subplot(2, 2, 4)
        plot(t, y, 'r');
        xlabel('t[s]'); ylabel('y(t)');
        title('Izlazni signal'); grid on;
    
%broj otkucaja srca je 90 po minutu
