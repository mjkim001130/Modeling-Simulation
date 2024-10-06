clc; clear; close all;

%% Define the RLC circuit system
function xdot = rlc_sys(t,x)
    R = 3; C = 10e-6; L = 10e-3; u = 0;
    A = [-R/L, 1/C;
         -1/L, 0];
    B = [0; 1/L];
    xdot = A*x + B*u;
end

%% Time span
t0 = 0; tf = 0.05; % Adjusted time span for RLC circuit
tspan = [t0, tf];

%% Initial conditions [current; voltage]
x0 = [0.1; 0]; % Starting with initial current, and zero voltage (across capacitor)

%% Solve ODE
[t, x] = ode45(@rlc_sys, tspan, x0);

%% Plot
figure;
set(gcf, 'Position', [100, 100, 1200, 500]); % Set window size to accommodate both plots

% RLC circuit current and voltage 
subplot('Position', [0.05, 0.1, 0.45, 0.8]); 
plot(t, x(:,1), 'b', 'LineWidth', 2); 
hold on;
plot(t, x(:,2), 'r', 'LineWidth', 2); 
xlabel('Time (s)');
ylabel('State Variables');
legend('Current (i)', 'Voltage (v)');
grid on;

% Phase portrait for RLC circuit 
subplot('Position', [0.55, 0.1, 0.4, 0.8]); 
plot(x(:,1), x(:,2));
xlabel('Current (i)');
ylabel('Voltage (v)');
title('Phase Portrait of RLC Circuit');
grid on;
