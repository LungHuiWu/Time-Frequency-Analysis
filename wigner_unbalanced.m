%% audioread input

[x_in, fs] = audioread('bird.wav');
t_start = 2;
t_end = 5;
f_start = 200;
f_end = 5000;
dt = 1/50;
dtau = 1/fs;
df = 1/2;   % Hz
S = dt/dtau;
x = x_in(t_start*fs:t_end*fs,1).';
x_star = conj(x);
%% input

n_tau = t_start/dtau:1:t_end/dtau;
n_t = (t_start/dt:1:t_end/dt)/S;
index_t = 1:1:length(n_t);
m = f_start/df:1:f_end/df;
n1 = index_t(1);
n2 = index_t(end);
N = 1/dt/df/2;
T = length(n_t);
F = length(m);

%% calculation

Wx = zeros(F, T);

for n0 = index_t
    c = zeros(1,N);
    Q = min(n2-n0,n0-n1);
    for q = 0:2*Q
        c(q+1) = x(n0*S+q-Q-n1*S+1) * x_star(n0*S-q+Q-n1*S+1);
    end
    C = fft(c, N);
    Wx(:,n0-n1+1) = 2 * dt * exp(1i * 2 * pi * m * Q / N) .* C(round(mod(m,N))+1);
end

%% plot
figure
Cc = 400;
image(n*dt, m*df, abs(Wx)/max(max(abs(Wx)))*Cc)   % C 是一個常數，我習慣選 C=400
% 或 image(t, f, abs(y)/max(max(abs(y)))*C) 
colormap(gray(256))         % 變成 gray-level 的圖
set(gca,'Ydir','normal')    % 若沒這一行, y-axis 的方向是倒過來的

set(gca,'Fontsize',12)        % 改變橫縱軸數值的 font sizes 
xlabel('Time (Sec)','Fontsize',12)             % x-axis
ylabel('Frequency (Hz)','Fontsize',12)      % y-axis
title('unbalanced wigner of x(t)','Fontsize',12)              % title

