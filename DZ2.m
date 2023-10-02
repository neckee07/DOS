close all; clear all; clc;

P=mod(527,4);
Q=mod(2017*(5+2+7),4);
R=mod(527*(2+0+1+7),4);
S=mod(527+2017,4);





[x, Fs]=audioread('audio2.wav');

fs=440;

t=0:1/Fs:(length(x)-1)/Fs;


b=[];
k=1;
for i=0:Fs/fs:length(x)
  b(k)= x(round(i+1));
  k=k+1;
end

t1=0:1/fs:(length(b)-1)/fs;

figure(1)
subplot(211)
  plot(t,x);
  xlabel('t[s]');
  ylabel('x[t]`');
  title('Originalni signal');
subplot(212)
   plot(t1,b);
  xlabel('t[s]');
  ylabel('x[t]`');
  title('Odabran signal');

N=2^nextpow2(length(x));
X=fft(x,N)/length(x);
X1=abs(X(1:N/2+1));
X1(2:N/2+1)=2*X1(2:N/2+1);
f1=0:Fs/N:Fs/2;
[pks,locs] = findpeaks(X1,f1,'MINPEAKDISTANCE', nthroot(2,12), 'MINPEAKHEIGHT',0.002314);

tonovi=[293.7 369.9 440.1];
pikovi=[0.2773 0.2779 0.2645];

figure(2)
subplot(311)
    plot(f1,X1);
    xlabel('f [Hz]');ylabel('|X(jf)|');
    title('Amplitudski spektar');
subplot(312)
    plot(locs,pks);
    xlabel('f [Hz]');ylabel('|X(jf)|');
subplot(313)
    stem(tonovi,pikovi);
    xlabel('f [Hz]');ylabel('|X(jf)|');
