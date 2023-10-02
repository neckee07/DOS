clear all; close all; clc;

[x, Fs]=audioread('audio3.wav');

fs= 4400;

t=0:1/Fs:(length(x)-1)/Fs;

b=[];
k=1;
for i=0:Fs/fs:length(x)
  b(k)= x(round(i+1));
  k=k+1;
end

t3=0:1/fs:(length(b)-1)/fs;
length(b)
length(x)
figure('Name','Audio+odabran')
subplot(211)
    plot(t,x);
    xlabel('t(s)');
    ylabel('x[t]');
    title('original');
subplot(212)
    plot(t3,b);
    xlabel('t[s]');
    ylabel('x(t)');
    title('odabran');
    
Min=16.35/2109.83;
N=2^nextpow2(length(x));
X=fft(x,N)/length(x);
fsN=0:Fs/N:Fs/2;
X1=abs(X(1:N/2+1));
X1(2:N/2+1)=2*X1(2:N/2+1);
[pks,locs] = findpeaks(X1,fsN,'MINPEAKDISTANCE', nthroot(2,12), 'MINPEAKHEIGHT',0.002314);

tonovi=[];
mesto=1;
klavir=[];
klbr=1;
pikovi=[];
i=16.35160;
koren=nthroot(2,12);

while i<=7902.133
    brojac=1;
    while brojac<=length(locs)
        if round(i)==round(locs(brojac))
             tonovi(mesto)=locs(brojac);
             pikovi(mesto)=pks(brojac);
             mesto=mesto+1;
        end
        brojac=brojac+1;
    end
  % klavir(klbr)=i;
   %klbr=klbr+1;
   i=i*koren;
end

figure('Name','Spektar+pikovi')
    subplot(311)
    plot(fsN,X1);
    xlabel('f [Hz]');ylabel('|X(jf)|');
    title('Amplitudski spektar');
    subplot(312)
    %findpeaks(X1,'MINPEAKDISTANCE', nthroot(2,12), 'MINPEAKHEIGHT',);
    plot(locs,pks);
    xlabel('f [Hz]');ylabel('|X(jf)|');
    subplot(313)
    stem(tonovi,pikovi);
    xlabel('f [Hz]');ylabel('|X(jf)|');
    axis([180 310 0 0.3])
    
    
