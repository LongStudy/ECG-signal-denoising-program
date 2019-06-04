function snr=SNR(I,In)
% I: original signal
% In: noisy signal(ie. original signal + noise signal)
% snr=10*log(sigma2(I2)/sigma2(I2-I1))
snr=0;
Ps=sum(abs(I).^2);%signal power
Pn=sum(abs(In-I).^2);%noise power
snr=10*log10(Ps/Pn);
