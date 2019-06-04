%singlefilterl2.m  ��ͨ�˲��� FIR

function [b,a]=singlefilterl2(wp,ws)

%ͨ����ֹƵ��wp=0.1*pi;
%�����ֹƵ��ws=0.16*pi;
wdelta=ws-wp;%���ɴ���
L_rectangle=4*pi;
L_bartlett=8*pi;
L_hanning=8*pi;
L_hamming=8*pi;
L_blackman=12*pi;
L_Kaiser=10*pi;

N=ceil(L_rectangle/wdelta);%���ڳ���,hanning��
Wn=(ws+wp)/2;%��ֹƵ��ȡֵ��Χ����ws��wp֮��
b=fir1(N-1,Wn/pi,rectwin(N));%������
a=1;
[H,W]=freqz(b,1,512);%��������ϵͳ�ķ�Ƶ��Ӧ����Ƶ��Ӧ, freqz��b��a��n������n�㸴Ƶ��Ӧʸ��H��n���Ƶ������w��b��aΪϵͳ���ݺ����ķ��Ӻͷ�ĸ��ϵ�����������nû��ָ����Ĭ��Ϊ512��
figure(6)
subplot(2,1,1);
plot(W/pi,20*log10(abs(H)));
grid
xlabel('w/pi')
ylabel('|H|(dB)')
title('��ͨ�˲��� FIR (dB)')
subplot(2,1,2);
plot(W/pi,abs(H));
grid
xlabel('w/pi')
ylabel('|H|')