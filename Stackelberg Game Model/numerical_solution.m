% �趨���ű�����ֵ
c = 0.5;  % �滻 c ��ֵ
a = 0.3;  % �滻 a ��ֵ
theta_g = 100;  % �滻 theta_g ��ֵ
F = 50;  % �滻 F ��ֵ
P_e = 10;  % �滻 P_e ��ֵ
P_g = 20;  % �滻 P_g ��ֵ
P_n = 15;  % �滻 P_n ��ֵ
q = 0.8;  % �滻 q ��ֵ
r = 0.5;  % �滻 r ��ֵ
Pr = 30;  % �滻 Pr ��ֵ
Cr = 25;  % �滻 Cr ��ֵ
lambda_g = 0.1;  % �滻 lambda_g ��ֵ
lambda_n = 0.2;  % �滻 lambda_n ��ֵ

% �������ű���
syms Y1 Y2 tau e_g e_n theta u_m u_g

% �������ģ�ͷ���ʽ���м���
C_g = Y1 + c * tau;
C_n = Y2;
theta_n = theta - theta_g - a * log(tau);
Et = P_e * (F - (e_g - tau) * theta_g - e_n * theta_n);
C_m = C_g * theta_g + C_n * theta_n - Et;
P_m = P_g * theta_g + P_n * theta_n;
u = u_m + u_g;
U_m = P_m - C_m + u;
U_r = q * (Pr - Cr - u) + r * (theta_g * (tau + lambda_g * u_g) + theta_n * lambda_n * u_m);

% ����һЩ��ʼ�²�ֵ
initial_guess = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; % ������Ҫ�������ģ�Ͷ���������ʵĳ�ʼ�²�ֵ

% ʹ�� fsolve ���
solutions = fsolve(@(variables) [
    subs(U_m, [Y1, Y2, tau, e_g, e_n, theta, u_m, u_g], variables), 
    subs(U_r, [Y1, Y2, tau, e_g, e_n, theta, u_m, u_g], variables)
], initial_guess);

% ��ע�⣬��Щ����ʽ������Ҫ�����Լ�����ʼ�²�ֵ���ܵõ���ֵ�⡣
