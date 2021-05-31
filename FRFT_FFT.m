%% parameters
phi = 0.5 * pi;
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
x1 = x .* exp(0.5i*cot(phi)*t.*t);
X1 = fft(x1,N);
a = sqrt((1-cot(phi)*1i)/2/pi);
b = exp(1i*cot(phi)/2*u.*u);
X = a * b .* X1(floor(mod(m*sin(phi),N))+1);

%% plot
figure
hold on
plot(u,real(X))
plot(u,imag(X))
hold off





