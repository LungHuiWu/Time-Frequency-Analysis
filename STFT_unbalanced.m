%% audioread

[x_in, fs] = audioread('bird.wav');
x = x_in(100000:360000,1).';

%% parameters

dt = 1/100;
dtau = 1/fs;
df = 1/2;           % Hz
sigma = 20;


%% time & freq interval

tau = 1*dtau : 1*dtau : length(x)*dtau;
n = tau/dtau;
T = length(tau);

f = 200:df:5000;
m = f/df;
F = length(f);

t = 1*dtau : 1*dt : length(x)*dtau;
c = t/dt;
C = length(t);

S = dt/dtau;
N = 1/dtau/df;
Q = floor(1.9143/sqrt(sigma)/dtau);
B = Q * dtau;

c0 = n(1);
m0 = m(1);
n0 = tau(1);

%% window function
w = -B:dtau:B;
w = (sigma^0.25)*exp(-pi*sigma.*w.*w);

%% padding
pad = zeros(1,Q);
x_pad = [pad x pad];

%x1 = conv(x_pad,w);
%x1 = x1(2*Q+1:2*Q+length(t));

%% output

i0 = 1;
x1 = zeros(1,N);
X_unb = zeros(length(f),length(t));
mk = round(mod(m,N))+1;
q = 1:2*Q+1;
for i = 1:C-1
    x1(1:2*Q+1) = w .* x_pad(i0 * S + q - 1);
    X1 = fft(x1(1:2*Q+1) .* w,N);
    X_unb(:,i) = X1(mk) .* exp(1i * 2 * pi * (Q-c(i0)*S) * mk / N) * dtau;
    i0 = i0 + 1;
end


%% plot
figure
C = 400;
image(t,f,abs(X_unb)/max(max(abs(X_unb)))*C)   % C 是一個常數，我習慣選 C=400
% 或 image(t, f, abs(y)/max(max(abs(y)))*C) 
colormap(gray(256))         % 變成 gray-level 的圖
set(gca,'Ydir','normal')    % 若沒這一行, y-axis 的方向是倒過來的

set(gca,'Fontsize',12)        % 改變橫縱軸數值的 font sizes 
xlabel('Time (Sec)','Fontsize',12)             % x-axis
ylabel('Frequency (Hz)','Fontsize',12)      % y-axis
title('STFT of x(t)','Fontsize',12)              % title


