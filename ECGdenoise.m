%ECGdenoise.m   ECG（心电图）信号去噪。

clear,clc;
val=importdata('Ecg.txt'); %fs=500hz
signal=val(1,1:1800);
fs=500;
figure(1)
subplot(4,1,1);
plot(signal);
title('干净的ECG信号');xlabel('采样点');ylabel('幅值（dB）');
grid on;
 
%加入高斯白噪声
Signal1=awgn(signal,10,'measured');        % 10dB.
subplot(4,1,2);
plot(Signal1);
title('加入高斯白噪声的信号');xlabel('采样点');ylabel('幅值（dB）');
grid on;
 
%加入工频干扰
av=100; %幅值AV
f0=50;
t=1:length(signal);
noise2=av*cos(2*pi*f0*t/fs);
Signal2=noise2+signal;
subplot(4,1,3);
plot(Signal2);
title('加入工频干扰的信号');xlabel('采样点');ylabel('幅值（dB）');
grid on;
 
%加入基线漂移
n1=length(signal)/3;
x1=zeros(1,n1);
t=1:length(signal)-n1;
x2=(length(signal)-n1)/2000*(t-1)+1;
noise3=[x1,x2];
Signal3=noise3+signal; 

t0=1:1250;
sg0=zeros(size(t0));
signalsg0=[signal,sg0];
n1sg0=length(signalsg0)/3;
x1sg0=zeros(1,1017);
t=1:length(signalsg0)-n1sg0;
x2sg0=(length(signalsg0)-n1sg0)/2000*(t-1)+1;
noise3sg0=[x1sg0,x2sg0];
Signal3sg0=noise3sg0+signalsg0; 

subplot(4,1,4);
plot(Signal3);
title('加入基线漂移的信号');xlabel('采样点');ylabel('幅值（dB）');
grid on;

%低通滤高斯白噪声
[b,a]=singlefilterl1(25,40,1,15,fs);
[b1,a1]=singlefilterl2(0.1*pi,0.16*pi);
Signal11p=filter(b,a,Signal1);
Signal12p=filter(b1,a1,Signal1);
figure(2)
subplot(4,1,1);plot(signal);title('ECG信号');grid on;
subplot(4,1,2);plot(Signal1);title('加入高斯白噪声的信号');grid on;
subplot(4,1,3);plot(Signal11p);title('低通IIR滤除高斯白噪声的信号');grid on;
subplot(4,1,4);plot(Signal12p);title('低通FIR滤除高斯白噪声的信号');grid on;

%带阻滤工频干扰
[b,a]=singlefilterbs([45 55],[48 52],1,15,fs);
Signal2p=filter(b,a,Signal2);
figure(3)
subplot(3,1,1);plot(signal);title('ECG信号');grid on;
subplot(3,1,2);plot(Signal2);title('加入工频干扰的信号');grid on;
subplot(3,1,3);plot(Signal2p);title('带阻滤除工频干扰的信号');grid on;

%高通滤基线漂移
[b,a]=singlefilterh1(0.7,0.3,1,15,fs);
Signal31p=filter(b,a,Signal3);
[b1,a1]=singlefilterh2(0.0028*pi,0.0012*pi);
Signal32p=filter(b1,a1,Signal3sg0);
figure(4)
subplot(4,1,1);plot(signal);title('ECG信号');grid on;
subplot(4,1,2);plot(Signal3);title('加入基线漂移的信号');grid on;
subplot(4,1,3);plot(Signal31p);title('高通IIR滤除基线漂移的信号');grid on;
subplot(4,1,4);plot(Signal32p);axis([1250,1250+1800,-100,120]);title('高通FIR滤除基线漂移的信号');grid on;



