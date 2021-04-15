%% factors

t_start = -4;
t_end = 4;
f_start = -4;
f_end = 4;
dt = 1/50;
df = 1/50;

t = t_start:dt:t_end;
f = f_start:df:f_end;
x = cos(2 * pi * t);
x_star = conj(x);
n = t/dt;
m = f/df;

%% padding

T = length(t);
F = length(f);
x_pad = [zeros(1,T) x zeros(1,T)];
x_star_pad = [zeros(1,T) x_star zeros(1,T)];
x_star_pad_flip = fliplr(x_star_pad);

%% output

X = zeros(F,T);

n1 = n(1);
n2 = n(end);

for i = 1:T
    Q = round(min(n(i)-n1, n2-n(i)));
    range_x = i+T-Q:1:i+T+Q;
    range_x_star = i+T+Q:-1:i+T-Q;
    range_p = -Q:1:Q;
    for j = 1:F
        X(j,i) = 2 * sum(x_pad(range_x) .* x_star_pad(range_x_star) .* exp(-1i * 4 * pi * f(j) * range_p * dt)) * dt;
    end
end



%% plot
figure
C = 400;
image(t, f, abs(X)/max(max(abs(X)))*C)   % C 是一個常數，我習慣選 C=400
% 或 image(t, f, abs(y)/max(max(abs(y)))*C) 
colormap(gray(256))         % 變成 gray-level 的圖
set(gca,'Ydir','normal')    % 若沒這一行, y-axis 的方向是倒過來的

set(gca,'Fontsize',12)        % 改變橫縱軸數值的 font sizes 
xlabel('Time (Sec)','Fontsize',12)             % x-axis
ylabel('Frequency (Hz)','Fontsize',12)      % y-axis
title('wigner of x(t)','Fontsize',12)              % title

