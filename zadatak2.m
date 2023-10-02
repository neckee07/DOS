clear all;close all;clc;
fullname = 'C:\Users\necaa\OneDrive\Desktop\audio2.wav';

[x,Fs]=audioread(fullname);
t=0:1/Fs:(length(x)-1)/Fs;

figure(1)
  plot(t,x);
  xlabel('t[s]');
  ylabel('x[t]');
  title('audiosignal');
 
 
 
  