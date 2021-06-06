%% parameters
a = 0;
b = 1;
c = -1;
d = 0;
N = 10000;
u_start = -20;
u_end = 20;
t_start = -20;
t_end = 20;
dt = 1/200;
du = 2*pi*b/N/dt;
u_start=round(u_start/du)*du;
u_end=round(u_end/du)*du;
u = u_start:du:u_end;
t = t_start:dt:t_end;
m = round(u/du);
n = round(t/dt);

%% input
x = cos(pi*t);
%% plot
figure
hold on
plot(t,real(x))
plot(t,imag(x))
hold off
xlim([-5,5]) %

%% output
x1 = x .* exp(0.5i*a/b*t.*t);
x1a=zeros(1,N);
x1a(mod(n,N)+1) = x1;
X1 = fft(x1a,N)*dt;
A = sqrt(1/2/pi/b/1i);
B = exp(0.5i*d/b*u.*u);
X = A * B .* X1(mod(m,N)+1);

%% plot
figure
hold on
plot(u,real(X))
plot(u,imag(X))
hold off
xlim([-5,5])

%% LCT again under (d,-b,-c,a)
%% parameters
a1 = d;
b1 = -b;
c1 = -c;
d1 = a;
M = 10000;
dt = 2*pi*b1/M/du;
t_start=round(t_start/dt)*dt;
t_end=round(t_end/dt)*dt;
u = u_start:du:u_end;
t = t_end:dt:t_start;
m = round(u/du);
n = round(t/dt);
%% output
y1 = X .* exp(0.5i*a1/b1*u.*u); 
y1a=zeros(1,M);
y1a(mod(m,M)+1) = y1;
Y1 = fft(y1a,M)*du;
A = sqrt(1/2/pi/b1/1i);
B = exp(0.5i*d1/b1*t.*t);
Y = A * B .* Y1(mod(n,M)+1);

%% plot
figure
hold on
plot(t,real(Y))
plot(t,imag(Y))
hold off
xlim([-5,5])
ylim([-1,1])
