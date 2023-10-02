close all; clear all; clc;

P=mod(527,4);
Q=mod(2017*(5+2+7),4);
R=mod(527*(2+0+1+7),4);
S=mod(527+2017,4);


N=10*(P+ 1); 


n1=0:N/2-1;
n2=N/2:N-1;
n=0:N-1;

x1=n1;
x2=1-n2-N;
x=cat(2,x1,x2);

y1=2*cos((P+ 1)*n1+pi*4);
y2=zeros(1,length(n2));
y=cat(2,y1,y2);

figure(1)
    subplot(211)
    stem(n,x);
    xlabel('n [odb]'); ylabel('x[n]');
    title('Signal x[n]'); grid on;
    subplot(212)
    stem(n,y);
    xlabel('n [odb]'); ylabel('y[n]');
    title('Signal y[n]'); grid on;


z=zeros(1,2*N-1); 
for i = 0:2*N-2
z(i + 1) = 0;
for m = 0:N-1
if i-m>=0 && i-m<=N-1
z(i + 1) = z(i + 1) + x(m+1) * y(i-m+1);
end
end
end


z2= zeros(1,N);

for k=0:N-1
    z2(k+1)= x*y(mod(k:(-1):(k-N+1),N)+1)';
end


xpros=[x zeros(1,N)];
ypros=[y zeros(1,N)];

z3 = ifft(fft(xpros).*fft(ypros));

figure(2)
  stem(z);
  xlabel('n [odb]'); ylabel('z [n]');
  title('Linearna konvolucija');
  grid on;

  
figure(3)
     stem(n, z2);
     xlabel('n [odb]'); ylabel('z2 [n]');
     title('Cirkularna konvolucija');
     grid on;

figure(4)
    stem(z3);
     xlabel('n [odb]'); ylabel('z3 [n], z [n]');
     title('Prosirena cirkularna konvolucija');
     grid on;
     hold on
     stem(z);  
     legend('z3[n]','z[n]');
     




