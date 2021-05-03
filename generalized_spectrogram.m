%% inputs

dt = 1/50;
df = 1/50;
t = -4:dt:4;
f = -4:df:4;
x = exp(-pi * t.^2);
sigma1 = 1;
sigma2 = 50;

%% parameters

n = t / dt;
m = f / df;
N = 1/dt/df;
T = length(t);
F = length(f);
Q1 = floor(1.9143/sqrt(sigma1)/dt);
Q2 = floor(1.9143/sqrt(sigma2)/dt);
B1 = Q1 * dt;
B2 = Q2 * dt;
i0 = 1;

%% window function
w1 = -B1:dt:B1;
w1 = (sigma1^0.25)*exp(-pi*sigma1.*w1.*w1);
w2 = -B2:dt:B2;
w2 = (sigma2^0.25)*exp(-pi*sigma2.*w2.*w2);

%% padding
pad1 = zeros(1,Q1);
x_pad1 = [pad1 x pad1];
pad2 = zeros(1,Q2);
x_pad2 = [pad2 x pad2];

%% calculation
x1 = zeros(1,N);
x2 = zeros(1,N);
X_fft = zeros(length(f),length(t));
mk = round(mod(m,N))+1;
q1 = 1:2*Q1+1;
q2 = 1:2*Q2+1;
for i = 1:T
    x1(1:2*Q1+1) = w1 .* x_pad1(i0+q1-1);
    X1 = fft(x1,N);
    x2(1:2*Q2+1) = w2 .* x_pad2(i0+q2-1);
    X2 = fft(x2,N);
    X_fft(:,i) = (X1(mk) .* exp(1i * 2 * pi * (Q1-n(i0)) * mk / N) * dt) .* (X2(mk) .* exp(1i * 2 * pi * (Q2-n(i0)) * mk / N) * dt);
    i0 = i0 + 1;
end

%% plot

figure
C = 400;
image(abs(X_fft)/max(max(abs(X_fft)))*C)   % C 是一個常數，我習慣選 C=400
% 或 image(t, f, abs(y)/max(max(abs(y)))*C) 
colormap(gray(256))         % 變成 gray-level 的圖
set(gca,'Ydir','normal')    % 若沒這一行, y-axis 的方向是倒過來的

set(gca,'Fontsize',12)        % 改變橫縱軸數值的 font sizes 
xlabel('Time (Sec)','Fontsize',12)             % x-axis
ylabel('Frequency (Hz)','Fontsize',12)      % y-axis
title('Generalized Spectrogram of x(t)','Fontsize',12)              % title
 
