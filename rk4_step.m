function ynew = rk4_step(f, t, y,h)
% RK4 한 스텝, f: 함수핸들 f(t,y), t: 현재시간, y: 현재상태, h: 스텝 크기

k1 = f(t,y);
k2 = f(t + h/2, y + h/2 * k1);
k3 = f(t + h/2, y + h/2 * k2);
k4 = f(t + h, y + h * k3);

ynew = y + (h/6) * (k1 + 2*k2 + 2*k3 + k4);
%중간지점 값(k2, k3)이 더 신뢰할 수 있어서 가중치 2씩 준다. 
end