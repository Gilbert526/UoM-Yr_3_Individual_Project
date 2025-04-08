%%%%%%%%%%%%%%%%%%% Constants %%%%%%%%%%%%%%%%%%%
%% Grid
V_grid = 230 * 4;
f_grid = 50;
w_grid = 2 * pi * f_grid;
phi_grid = 0;

%% DC Link
V_dc = 300;

%% Secondery AC Link
V_t = 230;
f_t = f_grid;

R_t = 0.15;     % Transmission Resistance
L_t = 5e-2;     % Transmission Inductance

P_rated_transformer = 10e3;

%% Inverter
P_rated_inverter = 3e3;

f_sw = 10000;    % Switching frequency
T_sw = 1 / f_sw;
T_p = T_sw;

K_cm = V_t / V_dc;  % PWM Gain

%% Controller
% PI
zeta = 0.707;

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

A_pwm_aug = [-R_t / L_t, w_grid, 1 / L_t , 0; -w_grid, -R_t / L_t, 0, 1 / L_t; 0, 0, -1 / T_p, 0; 0, 0, 0, -1 / T_p];
B_pwm_aug = [-1 / L_t, 0; 0, -1 / L_t; K_cm / T_p, 0; 0, K_cm / T_p];
C_pwm_aug = [0, 0, 1, 0; 0, 0, 0, 1];
D_pwm_aug = [0, 0; 0, 0];

sys = ss(A_pwm_aug, B_pwm_aug, C_pwm_aug, D_pwm_aug);

Q_lqr = diag([1000, 1000, 0.0001, 0.0001]);
R = 0.0001;

K_lqr = lqr(sys, Q_lqr, R);

% LQI
A_aug = [A_pwm_aug, zeros(4, 2); C_pwm_aug, zeros(2, 2)];
B_aug = [B_pwm_aug; zeros(2, 2)];
C_aug = [C, zeros(2,4)];
D_aug = 0;
sys_aug = ss(A_aug, B_aug, C_aug, D_aug);

Q_lqi = diag([3950, 3950, 0.00001, 0.00001, 100, 100]);

K_lqi = lqi(sys, Q_lqi, R);

%% Stability Test
%syms lambda
%char_poly = det(A_aug - lambda * eye(6)); % Compute determinant
%simplified_poly = simplify(char_poly) % Simplify the polynomial
%expanded_poly = expand(simplified_poly)
%pretty(expanded_poly)
%eigenvalues = solve(simplified_poly == 0, lambda)

%% Simulation
f_sample = 100000;
t_sample = 1 / f_sample;

t_breaker_on = 0.2;

P_target = 1500;
Q_target = 1000;



