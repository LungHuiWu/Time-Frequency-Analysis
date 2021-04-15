% Fourier Transform of Rectagular Pulse Function
n = -250:250; % sample points
N = 501;      % sampling size
dt = 1/250;   % delta t
x_rec = rectangularPulse(-0.5,0.5,n*dt);    % rectangular function

figure
plot(n*dt,x_rec)

% fourier tranform calculation
x_rec_f = zeros(501);
for p = 1:501
    for q = 1:501
        x_rec_f(p) = x_rec_f(p) + x_rec(q)*exp(-1i*2*pi*(p-1)*(q-1)/N);
    end
end
% shift to center
x_rec_f = fftshift(x_rec_f);
df = 2*pi/250;  % delta f

figure
plot(n*df,x_rec_f)

X = fft(x_rec);     % ft using fft function
X = fftshift(X);    % shift to center

figure
plot(n*df,X)
