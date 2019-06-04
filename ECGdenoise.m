%ECGdenoise.m   ECG���ĵ�ͼ���ź�ȥ�롣

clear,clc;
val=importdata('Ecg.txt'); %fs=500hz
signal=val(1,1:1800);
fs=500;
figure(1)
subplot(4,1,1);
plot(signal);
title('�ɾ���ECG�ź�');xlabel('������');ylabel('��ֵ��dB��');
grid on;
 
%�����˹������
Signal1=awgn(signal,10,'measured');        % 10dB.
subplot(4,1,2);
plot(Signal1);
title('�����˹���������ź�');xlabel('������');ylabel('��ֵ��dB��');
grid on;
 
%���빤Ƶ����
av=100; %��ֵAV
f0=50;
t=1:length(signal);
noise2=av*cos(2*pi*f0*t/fs);
Signal2=noise2+signal;
subplot(4,1,3);
plot(Signal2);
title('���빤Ƶ���ŵ��ź�');xlabel('������');ylabel('��ֵ��dB��');
grid on;
 
%�������Ư��
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
title('�������Ư�Ƶ��ź�');xlabel('������');ylabel('��ֵ��dB��');
grid on;

%��ͨ�˸�˹������
[b,a]=singlefilterl1(25,40,1,15,fs);
[b1,a1]=singlefilterl2(0.1*pi,0.16*pi);
Signal11p=filter(b,a,Signal1);
Signal12p=filter(b1,a1,Signal1);
figure(2)
subplot(4,1,1);plot(signal);title('ECG�ź�');grid on;
subplot(4,1,2);plot(Signal1);title('�����˹���������ź�');grid on;
subplot(4,1,3);plot(Signal11p);title('��ͨIIR�˳���˹���������ź�');grid on;
subplot(4,1,4);plot(Signal12p);title('��ͨFIR�˳���˹���������ź�');grid on;

%�����˹�Ƶ����
[b,a]=singlefilterbs([45 55],[48 52],1,15,fs);
Signal2p=filter(b,a,Signal2);
figure(3)
subplot(3,1,1);plot(signal);title('ECG�ź�');grid on;
subplot(3,1,2);plot(Signal2);title('���빤Ƶ���ŵ��ź�');grid on;
subplot(3,1,3);plot(Signal2p);title('�����˳���Ƶ���ŵ��ź�');grid on;

%��ͨ�˻���Ư��
[b,a]=singlefilterh1(0.7,0.3,1,15,fs);
Signal31p=filter(b,a,Signal3);
[b1,a1]=singlefilterh2(0.0028*pi,0.0012*pi);
Signal32p=filter(b1,a1,Signal3sg0);
figure(4)
subplot(4,1,1);plot(signal);title('ECG�ź�');grid on;
subplot(4,1,2);plot(Signal3);title('�������Ư�Ƶ��ź�');grid on;
subplot(4,1,3);plot(Signal31p);title('��ͨIIR�˳�����Ư�Ƶ��ź�');grid on;
subplot(4,1,4);plot(Signal32p);axis([1250,1250+1800,-100,120]);title('��ͨFIR�˳�����Ư�Ƶ��ź�');grid on;



