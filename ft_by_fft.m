dt = 1/250;
df = 1/50;
N = 12500;
n = -250:250;
m = -500:500;

% FT calculation
x_tri = zeros(1,length(m));
tri = triangularPulse(-0.5,0,0.5,n*dt);
f = m*df;
t = n*dt;
for p = 1:length(m)
    x_tri(p) = sum(tri.*exp(-i*2*pi*f(p)*t))*dt;
end
figure;
subplot(2,1,1);
plot(m*df,real(x_tri));

% using fft
x1 = zeros(1,N);
x1(mod(n,N)+1) = triangularPulse(-0.5,0,0.5,n*dt)*dt;
X = fft(x1);
X = fftshift(X);

subplot(2,1,2);
plot(m*df,real(X(m+6250)));

