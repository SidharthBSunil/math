
clear;
close all;

num_bit = 1e6;
EbNodB = 0:1:10;
EbNo = 10.^(EbNodB / 10);

for n = 1:length(EbNodB)
    si = 2 * (round(rand(1, num_bit)) - 0.5);
    sq = 2 * (round(rand(1, num_bit)) - 0.5);
    s = si + 1j * sq;
    w = (1 / sqrt(2 * EbNo(n))) * (randn(1, num_bit) + 1j * randn(1, num_bit));
    r = s + w;
    si_ = sign(real(r));
    sq_ = sign(imag(r));
    ber1 = (num_bit - sum(si == si_)) / num_bit;
    ber2 = (num_bit - sum(sq == sq_)) / num_bit;
    sim_BER(n) = mean([ber1 ber2]);
end

the_Ber = 0.5 * erfc(sqrt(10.^(EbNodB / 10)));

semilogy(EbNodB, sim_BER, '-');
hold on
semilogy(EbNodB, the_Ber, 'ko');
title('BER curve for QPSK modulation');
legend('Simulation', 'Theoretical');
xlabel('EbNo(dB)');
ylabel('BER');
grid on

