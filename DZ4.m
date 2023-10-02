clear all; close all; clc;


S=mod(527+2017,4);


Fs=250;
t=0:1/Fs:1;

x=2*sin(2*pi*25*t)+3*cos(2*pi*100*t+pi/8)-2*cos(2*pi*50*t);


N = 4*2^nextpow2(length(x));
f1 = 0:Fs/N:Fs/2;
X = fft(x,N)/length(x); 
X1 = abs(X(1:N/2+1));
X1(2:N/2+1) = 2*X1(2:N/2+1);

figure(1)
subplot(2, 2, 1:2)
    plot(t, x); 
    xlabel('t[s]'); ylabel('x(t)');
    title('Signal x(t)'); grid on;
subplot(2, 2, 3:4)
    plot(f1, X1);
    xlabel('f[Hz]'); ylabel('|X(jf)|');
    title('Amplitudska karakteristika'); grid on;
    
    
 n=40;
 window = blackman(n+1);
 Wn=[24 26, 99 101]/(Fs/2);
 b = fir1(n, Wn, window);
a = 1;
[hz, fz] = freqz(b, 1, N/2+1, Fs);


figure(2)
subplot(211)
    stem(window); 
    xlabel('n[odb]');
    title('Prozorska funkcija'); grid on;
subplot(212)
    plot(fz, 20*log10(abs(hz))); 
    xlabel('f [Hz]'); ylim([-140 20]);
    title('Amplitudska karakteristika filtra'); grid on;
    
% Filtriranje signala
y = filter(b, a, x);
Y = fft(y,N)/length(y); 
Y1 = abs(Y(1:N/2+1));
Y1(2:N/2+1) = 2*Y1(2:N/2+1); 

figure(3)
    subplot(2, 2, [1, 3])
        plot(f1, X1); hold on
        plot(f1, Y1); 
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
 
 
 
 
 