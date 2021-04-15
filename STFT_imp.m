%% inputs

dt = 1/50;
df = 1/50;
t = -4:dt:4;
f = -4:dt:4;
x = exp(-pi * t.^2);
sigma = 1;

%% parameters

n = t / dt;
m = f / df;

Q = floor(1.9143/sqrt(sigma)/dt);
B = Q * dt;

%% window function
w = -B:dt:B;
w = (sigma^0.25)*exp(-pi*sigma.*w.*w);

%% padding
pad = zeros(1,Q);
x_pad = [pad x pad];

%x1 = conv(x_pad,w);
%x1 = x1(2*Q+1:2*Q+length(t));

%% output

X = zeros(length(t),length(f));   

i = 1:2*Q+1;
for a = 1:length(m)
    for b = 1:length(n)
        X(a,b) = sum(w .* x_pad(b+i-1) .* exp(-1i * (n(b)+i-1-Q) * 2 * pi * dt * df * m(a)) * dt);
    end
end

%% plot
figure
C = 400;
image(abs(X)/max(max(abs(X)))*C)   % C 是一個常數，我習慣選 C=400
% 或 image(t, f, abs(y)/max(max(abs(y)))*C) 
colormap(gray(256))         % 變成 gray-level 的圖
set(gca,'Ydir','normal')    % 若沒這一行, y-axis 的方向是倒過來的

set(gca,'Fontsize',12)        % 改變橫縱軸數值的 font sizes 
xlabel('Time (Sec)','Fontsize',12)             % x-axis
ylabel('Frequency (Hz)','Fontsize',12)      % y-axis
title('STFT of x(t)','Fontsize',12)              % title
