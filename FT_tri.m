% Fourier Transform of triangular Pulse Function
n = -250:250; % sample points
N = 501;      % sampling size
dt = 1/250;   % delta t
x_tri = triangularPulse(-0.5,0,0.5,n*dt);    % triangular function
t=n*dt;
figure(1)
subplot(3,1,1)
plot(n*dt,x_tri)

% fourier tranform calculation
df=1/50;
f=[-250:250]*df;
M=length(f);
x_tri_f = zeros(1,501);
for p = 1:M
    % for q = 1:501
    x_tri_f(p) = x_tri_f(p) + sum(x_tri.*exp(-i*2*pi*f(p)*t))*dt; % *exp(-1i*2*pi*(p-1)*(q-1)/N);
    % end
end
% shift to center
% x_tri_f = fftshift(x_tri_f);
df = 2*pi/250;  % delta f

subplot(3,1,2)
plot(n*df,real(x_tri_f),n*df,imag(x_tri_f))

X = fft(x_tri);     % ft utrig fft function
X = fftshift(X);    % shift to center

subplot(3,1,3)
plot(n*df,real(X),n*dt,imag(X))
