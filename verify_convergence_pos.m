clear; clc; close all;

mu = 398600.4418;
r0 = 7000;
v0 = sqrt(mu/r0);                
n  = sqrt(mu/r0^3);               
y0 = [r0; 0; 0; 0; v0; 0];
tend = 58000;
hs = [40 20 10 5 2.5];
err = zeros(size(hs));

xexact = [r0*cos(n*tend); r0*sin(n*tend); 0];   
for i = 1:numel(hs)
    h = hs(i);
    N = tend / h;
    y = y0;
    t = 0;
    for k = 1:N
        y = rk4_step(@twobody_rhs, t, y, h);
        t = t + h;
    end
    err(i) = norm(y(1:3) - xexact);              % 위치 오차 [km]
end

loglog(hs, err, 'o-', hs, err(3)*(hs/hs(3)).^4, '--');
xlabel('step size h [s]'); ylabel('position error at t = 58000 s [km]');
legend('RK4 measured', 'slope 4 reference', 'Location', 'northwest');
title('Convergence of RK4 (position error vs analytic solution)'); grid on;

p = polyfit(log10(hs), log10(err), 1);
fprintf('수렴 차수(기울기) = %.2f\n', p(1));
saveas(gcf, 'convergence_pos.png');