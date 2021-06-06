%% parameters
phi = 0.4 * pi; % 0.05, 0.2, 0.4, 0.5 * pi;
N = 10000;
u_start = -5;
u_end = 5;
t_start = -5;
t_end = 5;
dt = 1/200; % modified
du = 2*pi/N/dt*sin(phi);
% Vary the values of u_start and u_end to a multiple of du
u_start=round(u_start/du)*du; % modified
u_end=round(u_end/du)*du; % modified
u = u_start:du:u_end;
t = t_start:dt:t_end;
m = round(u/du); % modified
n = round(t/dt); % modified
U = length(u);
T = length(t);

%% input
x = rectangularPulse(-2,2,t);

%% output
x1 = x .* exp(0.5i*cot(phi)*t.*t); 
% (mod(n,N)+1 should also be performed for the input  
x1a=zeros(1,N); % modified
x1a(mod(n,N)+1) =x1; % modified
X1 = fft(x1a,N)*dt; % modified
a = sqrt((1-cot(phi)*1i)/2/pi);
b = exp(1i*cot(phi)/2*u.*u);
X = a * b .* X1(mod(m,N)+1); % modified

%% plot
figure
hold on
plot(u,real(X))
plot(u,imag(X))
hold off
xlim([-5,5]) %  





