clear; clc; close all;

mu = 398600.4418;
y0 = [7000; 0; 0; 0; 7.546; 0]; %초기 상태 [km; km/s]
h = 10; %스텝 크기 [s]
T = 2*pi*sqrt(7000^3/mu); %궤도 주기 (약 5828s)
N = ceil(T/h); %스텝 수

Y = zeros(6, N+1); %결과 저장 공간(열 하나 = 한 시각의 상태)
Y(:, 1) = y0;
t = 0;
for k = 1:N
    Y(:, k+1) = rk4_step(@twobody_rhs, t, Y(:, k), h);
    t = t + h;    
end

plot(Y(1,:), Y(2,:)); axis equal; grid on;
xlabel('x [km]'); ylabel('y [km]'); title('Two-body orbit (RK4)');

E = @(y) norm(y(4:6))^2/2 - mu/norm(y(1:3));
fprintf('E0 = %.10f\nE_end = %.10f\n차이 = %.3e\n', E(Y(:,1)), E(Y(:,end)) - E(Y(:,1)));


