[s] = PLL_init(0.1, 1, 1.0, 2*pi/100, 1, 1024);

Nb = 10; %number of blocks
Ns = 100; %number of samples

load('ref_800hz');

%for changing amplitude
for j = 1:1000
    ref_in(j) = ref_in(j)*3;
end

in = reshape(ref_in, Ns, Nb);
out = zeros(Ns, Nb);

for n = 1:Nb
    [out(:,n), s] = PLL(in(:, n), Ns, s);
    plot(1:length(in(:, n)), in(:, n), 1:length(in(:, n)), out(:, n));
    %pause;
end

% y_output =  reshape(out, Ns*Nb, 1);
% y_input = ref_in;
% plot(1:length(y_input), y_input);
% hold on;
% plot(1:length(y_output), y_output, 'r');
% hold off;