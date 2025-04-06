%% Constants
%% Induction Machine
% Coil Windings

% Rotor

%% Primary AC Link

%% Full Bridge Rectifier

%% Grid
V_grid = 230 * 4;
f_grid = 50;
%f_grid = 60;
w_grid = 2 * pi * f_grid;
phi_grid = 0;

%% DC Link
V_dc = 300;

%% Secondery AC Link
V_t = 230;
f_t = f_grid;

R_t = 0.15;     % Transmission Resistance
L_t = 5e-2;     % Transmission Inductance
%R_t = 0.02;
%L_t = 0.002;

P_rated_transformer = 10e3;

%% Inverter
P_rated_inverter = 3e3;

f_sw = 10000;    % Switching frequency
T_sw = 1 / f_sw;

%K_cm = sqrt(3) * V_dc / 2;  % PWM Gain
T_p = T_sw;
K_cm = V_t / V_dc;

T_s = L_t / R_t;
K_s = 1 / R_t;

%% Controller
% PI
T_n = T_s;

K = K_cm * K_s;
T_i = 2 * K * T_sw;

zeta = 0.707;

% Original Paper
%Kp = 10000 * T_n / T_i;
%Ki = 500 * 1 / T_i;
%Kcp = w_grid * T_n / T_i;
Kcp = w_grid * L_t;

% CLTF w/out PWM
%Ki = w_grid * w_grid * L_t;
%Kp = 2 * L_t * w_grid * zeta - R_t;

% CLTF w/ PWM
alpha = (T_p * R_t + L_t) / (T_p * L_t) - 2 * zeta * w_grid;
Ki = alpha * w_grid * w_grid * T_p * L_t / K_cm;
Kp = (T_p * L_t * (2 * zeta * w_grid * alpha + w_grid * w_grid) - R_t) / K_cm;

Kp_ = 7000;
Ki_ = 10;

% LQR
A = [-R_t / L_t, w_grid; -w_grid, -R_t / L_t];
B = [1 / L_t, 0; 0, 1 / L_t];
C = eye(2);
D = 0;

A_pwm = [-1 / T_p, 0; 0, -1 / T_p];
B_pwm = [K_cm / T_p, 0; 0, K_cm / T_p];

%A_pwm_aug = [A, B; zeros(2, 2), A_pwm];
%B_pwm_aug = [zeros(2, 2); B_pwm];

A_pwm_aug = [-R_t / L_t, w_grid, 1 / L_t , 0; -w_grid, -R_t / L_t, 0, 1 / L_t; 0, 0, -1 / T_p, 0; 0, 0, 0, -1 / T_p];
B_pwm_aug = [-1 / L_t, 0; 0, -1 / L_t; K_cm / T_p, 0; 0, K_cm / T_p];
C_pwm_aug = [0, 0, 1, 0; 0, 0, 0, 1];
D_pwm_aug = [0, 0; 0, 0];

Q_lqr = diag([1000, 1000, 0.0001, 0.0001]);
%Q_lqi = diag([5000000, 5000000, 1000000, 1000000]);
Q_lqi = diag([3950, 3950, 0.00001, 0.00001, 100, 100]);
R = 0.0001;

%sys_aug = augstate(sys);
%A_aug = [A zeros(2,2);-C zeros(2,2)];
%B_aug=[B;zeros(2,2)];
%C_aug = [C zeros(2,2)];
%D_aug = zeros(2,2);
%sys = ss(A_aug, B_aug, C_aug, D_aug);

A_aug = [A_pwm_aug, zeros(4, 2); C_pwm_aug, zeros(2, 2)];
B_aug = [B_pwm_aug; zeros(2, 2)];
C_aug = [C, zeros(2,4)];
D_aug = 0;
sys = ss(A_pwm_aug, B_pwm_aug, C_pwm_aug, D_pwm_aug);
sys_aug = ss(A_aug, B_aug, C_aug, D_aug);

K_lqr = lqr(sys, Q_lqr, R);
K_lqi = lqi(sys, Q_lqi, R);
%K_lqi = lqr(sys_aug, Q_lqi, R);

%syms lambda
%char_poly = det(A_aug - lambda * eye(6)); % Compute determinant
%simplified_poly = simplify(char_poly) % Simplify the polynomial
%expanded_poly = expand(simplified_poly)
%pretty(expanded_poly)
%eigenvalues = solve(simplified_poly == 0, lambda)

%K_p_pll = 0.016;
%K_i_pll = 0.001;

%% Load
P_load = 2000;
Q_load = 1000;

%% Simulation
f_sample = 100000;
t_sample = 1 / f_sample;

t_breaker_on = 0.2;

P_target = 1500;
Q_target = 1000;



