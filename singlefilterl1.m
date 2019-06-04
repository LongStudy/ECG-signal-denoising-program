%singlefilterl1.m  µÍÍ¨ÂË²¨Æ÷ IIR

function [b,a]=singlefilterl1(fp,fs,ap,as,FS)
wp=fp*2*pi/FS;
ws=fs*2*pi/FS;
wap=2*FS*tan(wp/2);
was=2*FS*tan(ws/2);
[n,wn]=buttord(wap,was,ap,as,'s');
[z,p,k]=buttap(n);
[bp,ap]=zp2tf(z,p,k);
[bs,as]=lp2lp(bp,ap,wn);
[b,a]=bilinear(bs,as,FS);
[H,W]=freqz(b,a,1024);
figure(5)
subplot(2,1,1);
plot(W/pi,20*log10(abs(H)));
grid
xlabel('w/pi')
ylabel('|H|(dB)')
title('µÍÍ¨ÂË²¨Æ÷ IIR (dB)')
subplot(2,1,2);
plot(W/pi,abs(H));
grid
xlabel('w/pi')
ylabel('|H|')