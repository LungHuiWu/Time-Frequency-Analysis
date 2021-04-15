%% variables
sigma = 1;
dt = 1/50;
Q = floor(1.9143/(sqrt(sigma)*dt));
df = 5/250;
n = 0:1500; % t from 0 to 30
m = -250:250; % f from -pi to pi

%% calculation
X = zeros(501,1501);
% x = exp(-pi*t^2)
% w = sigma^(0.25)*exp(-pi*sigma*t^2)

for k = 1:length(m)
    for l = 1:length(n)
       for p =  n(l)-Q:n(l)+Q
           X(k,l) = X(k,l) + w(sigma,(n(l)-p)*dt) * x(p*dt) * exp(-1i * 2 * pi * p * m(k) * dt * df) * dt;
       end
    end
end

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

