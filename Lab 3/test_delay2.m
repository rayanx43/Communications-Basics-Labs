% test_delay2.m
%
% Script to test two delay blocks. Set up to model the way
% samples would be processed in a DSP program.
% Global parameters
Nb = 10; % Number of buffers
Ns = 128; % Samples in each buffer
Nmax = 200; % Maximum delay

Nd1 = 50; % Delay of the block 1
Nd2 = 70; % Delay of the block 2

% Initialize the delay blocks
state_delay1 = delay_init(Nmax, Nd1);
state_delay2 = delay_init(Nmax, Nd2);

% Generate some random samples.
x = randn(Ns*Nb, 1);
% Reshape into buffers
xb = reshape(x, Ns, Nb);
% Output samples
yb1 = zeros(Ns, Nb);
yb2 = zeros(Ns, Nb);
% Process each buffer in each block seperately

for bi=1:Nb,
 [state_delay1 yb1(:,bi)] = delay(state_delay1, xb(:,bi));
 % we update the value twice to compensate for 2 buffers
 [state_delay2 yb2(:,bi)] = delay(state_delay2, yb1(:,bi));
end


% Convert the new buffer back into a contiguous signal.
y = reshape(yb2, Ns*Nb, 1);
% Check if it worked right
n = [0:length(x)-1];
figure(1);
plot(n, x, n, y);
figure(2);
plot(n+Nd1+Nd2, x, n, y, 'x');
% Do a check and give a warning if it is not right. Skip first buffer
% in check
% to avoid initial conditions.
n_chk = 1+[Ns:(Nb-1)*Ns-1];
if any(x(n_chk - Nd1 - Nd2) ~= y(n_chk)),
 warning('A mismatch was encountered.');
end
