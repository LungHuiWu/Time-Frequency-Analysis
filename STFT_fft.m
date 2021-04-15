%% inputs

dt = 1/50;
df = 1/50;
t = -4:dt:4;
f = -4:df:4;
x = exp(-pi * t.^2);
sigma = 1;

%% parameters

n = t / dt;
m = f / df;
N = 1/dt/df;
T = length(t);
F = length(f);
Q = floor(1.9143/sqrt(sigma)/dt);
B = Q * dt;
i0 = 1;

%% window function
w = -B:dt:B;
w = (sigma^0.25)*exp(-pi*sigma.*w.*w);

%% padding
pad = zeros(1,Q);
x_pad = [pad x pad];

%% calculation
x1 = zeros(1,N);
X_fft = zeros(length(f),length(t));
mk = round(mod(m,N))+1;
q = 1:2*Q+1;
for i = 1:T
    x1(1:2*Q+1) = w .* x_pad(i0+q-1);
    X1 = fft(x1,N);
    X_fft(:,i) = X1(mk) .* exp(1i * 2 * pi * (Q-n(i0)) * mk / N) * dt;
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
title('STFT of x(t)','Fontsize',12)              % title
 
