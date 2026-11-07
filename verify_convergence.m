clear; clc; close all;

mu = 398600.4418;
y0 = [7000; 0; 0; 0; 7.546; 0];
tend = 58000; %전파 시간 [s], 약 10주기
hs = [40 20 10 5 2.5];

Efun = @(s) norm(s(4:6))^2/2 - mu/norm(s(1:3));
E0 = Efun(y0);
err = zeros(size(hs));

for i = 1:numel(hs)
    h = hs(i);
    N = tend / h;
    y = y0;
    t = 0;
    for k = 1:N
        y = rk4_step(@twobody_rhs, t, y, h);
        t = t + h;
    end
    err(i) = abs((Efun(y) - E0) / E0);

end

loglog(hs, err, 'o-', hs, err(3)*(hs/hs(3)).^4, '--');
xlabel('step size h [s]');
ylabel('relative energy error at t = 58000 s');
legend('RK4 measured', 'slope 4 reference', 'Location', 'northwest');
title('Convergence of RK4');
grid on;

p = polyfit(log10(hs), log10(err), 1);
fprintf('수렴 차수(기울기) = %.2f\n', p(1));
saveas(gcf, 'convergence.png');
