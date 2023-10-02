clear all; close all; clc;

n1=0:18
n=0:9;
x=n/2;
y=2*sin(1.5*n+pi/3);

figure(1)
   subplot(2,1,1)
   stem(n,x); %za crtanje diskretnih signala
   xlabel('n [odb]'); ylabel('x[n]');
   title('signal x[n]'); grid on;
   subplot(2,1,2)
   stem(n,y); %za crtanje diskretnih signala
   xlabel('n [odb]'); ylabel('y[n]');
   title('signal y[n]'); grid on;
   
   
N=length(x);
z = [];
% z=zeros(1,2*N-1) inicijalizacija pre for petlje
for i = 0:2*N-2
z(i + 1) = 0;
for m = 0:N-1
if i-m>=0 && i-m<=N-1
z(i + 1) = z(i + 1) + x(m+1) * y(i-m+1);
end
end
end
z2 = zeros(1,N);

for k = 0:N-1
    z2(k+1) = x*y(mod(k:(-1):(k-N+1),N)+1)';
end


figure(2)
  stem(z);
  hold on
  stem(z2);
length(z)

   