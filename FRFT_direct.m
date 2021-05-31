%% parameters
phi = 0.01 * pi;
N = 10000;
u_start = -5;
u_end = 5;
t_start = -5;
t_end = 5;
dt = 1/50;
du = 2*pi/N/dt*sin(phi);

u = u_start:du:u_end;
t = t_start:dt:t_end;
m = u/du;
n = t/dt;
U = length(u);
T = length(t);

%% input
x = rectangularPulse(-2,2,t);

%% output
X = zeros(U);
a = sqrt((1-cot(phi)*1i)/2/pi);
for i = 1:U
    b = exp(1i*cot(phi)/2*u(i)*u(i));
    X(i) = a * b * sum(exp(-1i*u(i)*t/sin(phi)) .* exp(1i*cot(phi)/2*t.*t) .* x) * dt;
end

%% plot
figure
hold on
plot(u,real(X))
plot(u,imag(X))
hold off

%{
figure
C = 400;
image(t, u, abs(X)/max(max(abs(X)))*C)   % C 是一個常數，我習慣選 C=400
% 或 image(t, f, abs(y)/max(max(abs(y)))*C) 
colormap(gray(256))         % 變成 gray-level 的圖
set(gca,'Ydir','normal')    % 若沒這一行, y-axis 的方向是倒過來的

set(gca,'Fontsize',12)        % 改變橫縱軸數值的 font sizes 
xlabel('Time (Sec)','Fontsize',12)             % x-axis
ylabel('Frequency (Hz)','Fontsize',12)      % y-axis
title('FRFFT of x(t) with phi = pi/4','Fontsize',12)              % title
%}
