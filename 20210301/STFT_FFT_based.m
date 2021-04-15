%% variables
dt = 1/50;
df = 5/250;
N = 2500;
sigma = 1;
Q = floor(1.9143/(sqrt(sigma)*dt));
n0 = -250;
m = -250:250;
m0 = -250;
T = 501;
F = 501;

%% calculation
n = n0;

x1 = zeros(N+1);
X1 = zeros(F);
X_fft = zeros(501,500);
for l = 1:T-1
    % update x1
    for i = 1:2*Q+1
        x1(i) = w(sigma,(Q-i+1)*dt) * xx((n-Q+i-1)*dt);
    end
    X1 = fft(x1,N);
    for k = 1:length(m)
        X_fft(k,l) = X1(mod(m(k),N)+1) * exp(1i * 2 * pi * (Q-n) * m(k) / N) * dt;
    end
    n = n+1;
end

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
    
    
    
    


