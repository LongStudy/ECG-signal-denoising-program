%singlefilterh2.m  高通滤波器 FIR

function [b,a]=singlefilterh2(wp,ws)

%通带截止频率wp=0.0028*pi;
%阻带截止频率ws=0.0012*pi;
wdelta=wp-ws;%过渡带宽
L_rectangle=4*pi;
L_bartlett=8*pi;
L_hanning=8*pi;
L_hamming=8*pi;
L_blackman=12*pi;
L_Kaiser=10*pi;

N=ceil(L_rectangle/wdelta);%窗口长度,hanning窗
Wn=(ws+wp)/2;%截止频率取值范围，在ws，wp之间
win=rectwin(N+1);
b=fir1(N,Wn/pi,'high',win);%窗函数

a=1;
[H,W]=freqz(b,1,512);%计算线性系统的幅频响应和相频响应, freqz（b，a，n）返回n点复频响应矢量H和n点的频率向量w。b和a为系统传递函数的分子和分母的系数向量。如果n没有指定，默认为512。
figure(9)
subplot(2,1,1);
plot(W/pi,20*log10(abs(H)));
grid
xlabel('w/pi')
ylabel('|H|(dB)')
title('高滤波器 FIR (dB)')
subplot(2,1,2);
plot(W/pi,abs(H));
grid
xlabel('w/pi')
ylabel('|H|')