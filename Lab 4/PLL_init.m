function [s] = PLL_init(f, D, k, w0, T, table_size)
%defining parameters

s.f = f;
s.D = D;
s.k = k;
s.w0 = w0;
s.T = T;

%creating a look-up table

for i=0 : table_size-1
    s.sine_table(i+1) = sin(2*pi*i/table_size);
end

%initializing filter coefficients

s.tau1 = s.k/(s.w0)^2;
s.tau2 = 2*s.D/s.w0 - 1/s.k;
s.a1 = -(s.T - 2*s.tau1) / (s.T + 2*s.tau1);
s.b0 = (s.T + 2*s.tau2) / (s.T + 2*s.tau1);
s.b1 = (s.T - 2*s.tau2) / (s.T + 2*s.tau1);

%initializing state variables

s.out_old = 0.0;
s.z_old = 0.0;
s.v_old = 0.0;
s.accum = 0.0;


end

