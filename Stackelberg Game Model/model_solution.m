clc; clear;

% ������ű���
syms omega y0 c tau lambda beta u pe e theta_0 a F q p D

% ���ò����������Լ������
assume([omega, y0, c, tau, lambda, beta, u, pe, e, theta_0, a, F, q, p, D] > 0);

% ����ɱ��ֵ�����+��������Ч�ú���
U_m = (omega - y0 - c * (tau + lambda * u)^2 - pe * (e - tau - lambda * u)) * (theta_0 + a * log(tau + lambda * u) - beta * p) + pe * F + u;
U_r = (q * (p - omega) + (1 - q) * (tau + lambda * u)) * (theta_0 + a * log(tau + lambda * u) - beta * p) - q * (D + u);

% ���� Hessian ����
dU_p = diff(U_r, p);
dU_tau = diff(U_r, tau);

d2U_p_p = diff(dU_p, p);
d2U_p_tau = diff(dU_p, tau);
d2U_tau_p = diff(dU_tau, p);
d2U_tau_tau = diff(dU_tau, tau);

Hessian = [d2U_p_p, d2U_p_tau; d2U_tau_p, d2U_tau_tau];
disp('Hessian matrix:');
disp(Hessian);

% ��� Hessian ��������ʽ������
% ���� Hessian ����˳������ʽ���㽻��Ϊ������������ʽΪ��������
minor1 = d2U_p_p;
minor2 = det([d2U_p_p, d2U_p_tau; d2U_tau_p, d2U_tau_tau]);

if isAlways(minor1 < 0) && isAlways(minor2 > 0)
    disp('Leading principal minors alternately negative and positive, determinant positive.');
    
    % ���Խ����������
    try
        sol = solve([dU_p == 0, dU_tau == 0], [p, tau]);
        disp('Parameter equations for saddle point:');
        disp(sol);
    catch
        disp('Unable to determine parameter equations.');
    end
    
else
    disp('Conditions for saddle point not met.');
    disp('Unable to determine parameter equations.');
end
