%% inputs

dt = 1/50;
df = 1/50;
t_start = -4;
t_end = 4;
f_start = -4;
f_end = 4;
n = t_start/dt:1:t_end/dt;
m = f_start/df:1:f_end/df;
t = n * dt;
f = m * df;
x = exp(-pi * t.^2);
x_star = conj(x);
sigma = 1;

%% parameters

n1 = n(1);
n2 = n(end);
N_stft = 1/dt/df;
N_wigner = 1/dt/df/2;
T = length(n);
F = length(m);
Q = floor(1.9143/sqrt(sigma)/dt);
B = Q * dt;
i0 = 1;

%% window function
w = -B:dt:B;
w = (sigma^0.25)*exp(-pi*sigma.*w.*w);

%% padding
pad = zeros(1,Q);
x_pad = [pad x pad];

%% calculation of STFT
x1 = zeros(1,N_stft);
X_fft = zeros(F,T);
mk = round(mod(m,N_stft))+1;
q = 1:2*Q+1;
for i = 1:T
    x1(1:2*Q+1) = w .* x_pad(i0+q-1);
    X1 = fft(x1,N_stft);
    X_fft(:,i) = X1(mk) .* exp(1i * 2 * pi * (Q-n(i0)) * mk / N_stft) * dt;
    i0 = i0 + 1;
end

%% calculation of wigner

Wx = zeros(F, T);

for n0 = n
    c = zeros(1,N);
    Q_wig = min(n2-n0,n0-n1);
    for q = 0:2*Q_wig
        c(q+1) = x(n0+q-Q_wig-n1+1) * x_star(n0-q+Q_wig-n1+1);
    end
    C = fft(c, N);
    Wx(:,n0-n1+1) = 2 * dt * exp(1i * 2 * pi * m * Q_wig / N) .* C(round(mod(m,N))+1);
end

%% multiplication

G_W = X_fft .* Wx;

%% plot

figure
C = 400;
image(abs(G_W)/max(max(abs(G_W)))*C)   % C 是一個常數，我習慣選 C=400
% 或 image(t, f, abs(y)/max(max(abs(y)))*C) 
colormap(gray(256))         % 變成 gray-level 的圖
set(gca,'Ydir','normal')    % 若沒這一行, y-axis 的方向是倒過來的

set(gca,'Fontsize',12)        % 改變橫縱軸數值的 font sizes 
xlabel('Time (Sec)','Fontsize',12)             % x-axis
ylabel('Frequency (Hz)','Fontsize',12)      % y-axis
title('Gabor_Wigner of x(t)','Fontsize',12)              % title

