
N = 2000;
M = 16;
Fs = 1e6;
Rb = 1e5;
alpha = 0.5;
span = 6;
sps = Fs/Rb;

data = randi([0, M-1], N, 1);
symbols = qammod(data, M, 'UnitAveragePower', true);

tx_signal = zeros(N*sps,1);
tx_signal(1:sps:end) = symbols;
rrcos = rcosdesign(alpha, span, sps);
pulse_shaped = conv(tx_signal, rrcos, 'same');

SNR = 20;
noisy_signal = awgn(pulse_shaped, SNR, 'measured');

matched_signal = conv(noisy_signal, fliplr(rrcos), 'same');

figure;
eyediagram(matched_signal, 2*sps);

received_symbols = matched_signal(1:sps:end);
figure;
scatterplot(received_symbols);
title('Received Constellation');

demodulated_data = qamdemod(received_symbols, M, 'UnitAveragePower', true);
errors = sum(demodulated_data ~= data);
BER = errors/N;
disp(['Bit Error Rate (BER): ', num2str(BER)]);

