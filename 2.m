
N = 1000;
symbol_rate = 1e6;
oversampling_rate = 8;
sample_rate = symbol_rate * oversampling_rate;
t = (0:N-1)/sample_rate;

symbols = 2*round(rand(1, N/oversampling_rate)) - 1;

rolloff = 0.25;
h = rcosdesign(rolloff, 6, oversampling_rate, 'sqrt');

x = upsample(symbols, oversampling_rate);
x_shaped = conv(x, h, 'same');

SNR_dB = 10;
noise_power = 10^(-SNR_dB/10) * var(x_shaped);
noise = sqrt(noise_power/2) * (randn(size(x_shaped)) + 1i*randn(size(x_shaped)));
received_signal = x_shaped + noise;

matched_filter = conj(fliplr(h));
y = conv(received_signal, matched_filter, 'same');

estimated_symbols = y(1:oversampling_rate:end);

figure;
subplot(3,1,1);
plot(t, real(x_shaped));
title('Pulse Shaped Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, real(received_signal));
title('Received Signal with Noise');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t(1:oversampling_rate:end), real(estimated_symbols));
title('Estimated Symbols after Matched Filtering');
xlabel('Time (s)');
ylabel('Amplitude');

original_symbols = symbols;
errors = sum(original_symbols ~= sign(real(estimated_symbols)));
BER = errors / length(symbols);
fprintf('Bit Error Rate: %.4e\n', BER);
