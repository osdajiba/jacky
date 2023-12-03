clc; clear;

% 定义符号变量
syms omega y0 c tau lambda beta u pe e theta_0 a F q p D

% 设置参数大于零的约束条件
assume([omega, y0, c, tau, lambda, beta, u, pe, e, theta_0, a, F, q, p, D] > 0);

% 定义成本分担策略+代销渠道效用函数
U_m = (omega - y0 - c * (tau + lambda * u)^2 - pe * (e - tau - lambda * u)) * (theta_0 + a * log(tau + lambda * u) - beta * p) + pe * F + u;
U_r = (q * (p - omega) + (1 - q) * (tau + lambda * u)) * (theta_0 + a * log(tau + lambda * u) - beta * p) - q * (D + u);

% 计算 Hessian 矩阵
dU_p = diff(U_r, p);
dU_tau = diff(U_r, tau);

d2U_p_p = diff(dU_p, p);
d2U_p_tau = diff(dU_p, tau);
d2U_tau_p = diff(dU_tau, p);
d2U_tau_tau = diff(dU_tau, tau);

Hessian = [d2U_p_p, d2U_p_tau; d2U_tau_p, d2U_tau_tau];
disp('Hessian matrix:');
disp(Hessian);

% 检查 Hessian 矩阵行列式大于零
% 假设 Hessian 矩阵顺序主子式满足交替为负正，但行列式为正的条件
minor1 = d2U_p_p;
minor2 = det([d2U_p_p, d2U_p_tau; d2U_tau_p, d2U_tau_tau]);

if isAlways(minor1 < 0) && isAlways(minor2 > 0)
    disp('Leading principal minors alternately negative and positive, determinant positive.');
    
    % 尝试解出参数方程
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
