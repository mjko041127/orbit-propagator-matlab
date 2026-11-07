clear; clc; close all;

mu = 398600.4418;
y0 = [7000; 0; 0; 0; 7.546; 0];
h = 10;
T = 2*pi*sqrt(7000^3/mu);
N = ceil(10*T/h);  %10주기

Y = zeros(6, N+1);
Y(:, 1) = y0;
t = 0;
for k = 1:N
    Y(:, k+1) = rk4_step(@twobody_rhs, t, Y(:, k), h);
    t = t + h;
end

tvec = (0:N) * h / T;  %시간축 (단위: 주기)

E = zeros(1, N+1);
for k = 1:N+1
    E(k) = norm(Y(4:6, k))^2/2 - mu/norm(Y(1:3, k));
end

relerr = abs((E - E(1)) / E(1));

semilogy(tvec(2:end), relerr(2:end));
xlabel('time [orbits]');
ylabel('|\DeltaE / E_0|');
title('Energy error, RK4, h = 10s');
grid on;

fprintf('10주기 후 상대 오차 = %.3e\n', relerr(end));

saveas(gcf, 'energy_error.png');