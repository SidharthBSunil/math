````
clear;
close all;

time = 0:.0005:.05;
freq_msg = 100;
dc_ofst = 2;
signal = sin(2*pi*freq_msg*time) + dc_ofst;

figure;
plot(time, signal)
xlabel('time')
ylabel('Amplitude')
title('Signal')

freq_sample = 15 * freq_msg;
samp_time = 0:1/freq_sample:0.05;
samp_signal = dc_ofst + sin(2*pi*freq_msg*samp_time);

hold on
plot(samp_time, samp_signal, 'rx')
title('Sampled Signal')
legend('Original signal', 'Sampled signal');

L = 8;
smin = round(min(signal));
smax = round(max(signal));
Quant_levl = linspace(smin, smax, L);
codebook = linspace(0, smax, L+1);
[index, quants] = quantiz(samp_signal, Quant_levl, codebook);

figure;
plot(samp_time, samp_signal, 'x', samp_time, quants, '.-')
title('Quantized Signal')
legend('Original signal', 'Quantized signal');

figure;
plot(samp_time, index, '.-')
title('Encoded Signal')

for i = 1:length(index)
    bincode_sig{i} = dec2bin(round(index(i)), 7);
end
disp(bincode_sig)

noise = quants - samp_signal;
figure;
plot(samp_time, noise, '.-')
title('Noise')

r = snr(index, noise);
disp(['SNR :', num2str(r)])

````
