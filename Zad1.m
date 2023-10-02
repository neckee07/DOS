clear all;close all;clc;
syms n

x= piecewise(0<=n<=9, n, 10<=n<=19, -19-n, 0);

y= piecewise(0<=n<=9, 2*cos(2*n+pi/4), 0);

N=20;

R=0:19;

linearna=[];
for i=0:2*N-2
    linearna(i+1)=0;
    for m=0:N-1
        if i-m>=0 && i-m<=N-1
            linearna(i+1)=linearna(i+1)+subs(x, n, m+1)*subs(y, n, i-m);
        end
    end
end

x2=[];
a=[];
for k=0:19
    x2(k+1)=subs(x, n, k);
    a(k+1)=subs(y, n, k);
end

l=conv(x2,a);

br1=numel(l);

figure
subplot(211)
stem(0:br1-1,linearna)
ylabel('z[n]'); xlabel('n[odb]');
title('linearna konvolucija');
axis([0 40 -100 100])
subplot(212)
stem(0:br1-1,l)
axis([0 40 -100 100])
title('Potvrda');

K=length(x2);
cirkularna=[];
for i=0:K-1
    cirkularna(i+1)=0;
    for m=0:K-1
        cirkularna(i+1)=cirkularna(i+1)+subs(x,n,(m))*subs(y,n,(mod(i-m,K)));
    end
end

c=cconv(x2,a,K);

figure
subplot(211)
stem(R,cirkularna);
ylabel('z[n]');xlabel('n[odb]');
title('cirkularna konvolucija');
axis([0 20 -100 100])
subplot(212)
stem(R,c)
title('Potvrda');
axis([0 20 -100 100])

%------------------------IDFT

Xfft=fft(x2);
Yfft=fft(a);

Zfft=Xfft.*Yfft;

IDFTcirkularna=ifft(Zfft);

G=numel(x2);
G1=numel(a);

Gpad=[x2 zeros(1,G1-1)];
G1pad=[a zeros(1,G-1)];

Xfft1=fft(Gpad);
Yfft1=fft(G1pad);

Zfft1=Xfft1.*Yfft1;
%zfft1=abs(Zfft1);
IDFTlinearna=ifft(Zfft1);
br=numel(IDFTlinearna);

figure
subplot(211)
stem(R,IDFTcirkularna);
title('cirkularna preko IDFT');
ylabel('z[n]');xlabel('n[odb]');
subplot(212)
stem(0:br-1,IDFTlinearna);
title('linearna preko IDFT');
ylabel('z[n]');xlabel('n[odb]');
axis([0 40 -100 100])

pokl=[];

for i=0:19
    
    L1=round(l(i+1),4);
    C1=round(c(i+1),4);
    pokl(i+1)=1;
    if L1~=C1
        pokl(i+1)=0;
    end
end

for i=20:39
    pokl(i+1)=0;
end

figure
subplot(211)
stem(R,IDFTcirkularna);
hold on
stem(0:br-1,IDFTlinearna);
title('Preklapanje');
legend(['cirkularna'],['linearna']);
subplot(212)
stem(0:39,pokl);


