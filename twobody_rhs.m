function dy = twobody_rhs(t, y)
%2체 문제 운동 방정식, y = [r; v](6x1), 단위 km, km/s

mu = 398600.4418; %지구 중력상수 
r = y(1:3);
v = y(4:6);

dr = v;
dv = -mu * r / norm(r)^3;

dy = [dr; dv];
end