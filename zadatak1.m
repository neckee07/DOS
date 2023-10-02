clear all;close all;clc;

f1=120;
f2=60;

fs=1000;

t=0:1/fs:0.1;


x=sin(2*pi*f1*t)+sin(2*pi*f2*t);

 
    
fod=200;
t2=0:1/fod:0.1;
x2=sin(2*pi*f1*t2)+sin(2*pi*f2*t2);
x3=sin(2*pi*80*t+pi)+sin(2*pi*60*t);


figure(1)
    plot(t,x);
    hold on
    scatter (t2,x2,'r*');
    plot(t,x3,'r');
    xlabel('t [s]');ylabel('x [t]');
    title('signalx[t]');
    grid on;    
    legend('kvazikontinualni','diskretni fs=200','kontinualni fs=200');
    
    
 
    
    
    