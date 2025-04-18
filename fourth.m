
clear;
close all;

num_bit = 1e6;
EbNodB = 0:1:10;

for i = 1:length(EbNodB)
    s = 2 * (round(rand(1, num_bit)) - 0.5);
    w = (1 / sqrt(2 * 10^(EbNodB(i) / 10))) * randn(1, num_bit);
    r = s + w;
    s_est = sign(r);
    sim_BER(i) = (num_bit - sum(s == s_est)) / num_bit;
end

the_Ber = 0.5 * erfc(sqrt(10.^(EbNodB / 10)));

semilogy(EbNodB, sim_BER, '-');
hold on
semilogy(EbNodB, the_Ber, 'ko');
title('BER curve for BPSK modulation');
legend('Simulation', 'Theoretical');
xlabel('EbNo(dB)');
ylabel('BER');
grid on

