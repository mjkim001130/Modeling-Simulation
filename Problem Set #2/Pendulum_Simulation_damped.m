clc; clear; close all;

%% Define the damped pendulum system
function xdot = pendulum_damped(t,x)
    m = 1; L = 2; g = 9.81; c = 0.5;
    xdot = zeros(2,1);
    xdot(1) = x(2);
    xdot(2) = (-g/L)*sin(x(1)) - c*x(2);
end

%% Time span
t0 = 0; tf = 20;
tspan = [t0, tf];

%% Initial conditions [angle; angular velocity]
x0 = [pi/4; 0];

%% Solve ODE
[t, x] = ode45(@pendulum_damped, tspan, x0);

%% Plot
figure;
set(gcf, 'Position', [100, 100, 1200, 500]); % Set window size to accommodate both plots

% Pendulum simulation
subplot('Position', [0.05, 0.1, 0.45, 0.8]); % Position for the first plot (x, y, width, height)
grid on;
axis equal
axis([-2.5, 2.5, -2.5, 2.5]);
hold on;
xlabel('x');
ylabel('y');
title('Damped Pendulum Simulation');

% Parameters for pendulum
L = 2; % Length of pendulum
pivot_x = 0;
pivot_y = 0;

% Draw the pivot point
plot(pivot_x, pivot_y, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

% Initialize pendulum arm and mass
pendulum_arm = line([pivot_x, pivot_x], [pivot_y, pivot_y-L], 'Color', 'b', 'LineWidth', 2);
pendulum_mass = plot(pivot_x, pivot_y-L, 'ro', 'MarkerSize', 20, 'MarkerFaceColor', 'r');

% Phase plot
subplot('Position', [0.55, 0.1, 0.4, 0.8]); % Position for the second plot (x, y, width, height)
plot(x(:,1), x(:,2));
xlabel('\theta (Angle)');
ylabel('\omega (Angular Velocity)');
title('Phase Plot (Damped Pendulum)');
grid on;

% Animation
for i = 1:length(t)
    % Update pendulum position
    subplot('Position', [0.05, 0.1, 0.45, 0.8]);
    theta = x(i,1);
    pendulum_x = L * sin(theta);
    pendulum_y = -L * cos(theta);
    
    % Update pendulum arm and mass
    set(pendulum_arm, 'XData', [pivot_x, pivot_x + pendulum_x], 'YData', [pivot_y, pivot_y + pendulum_y]);
    set(pendulum_mass, 'XData', pivot_x + pendulum_x, 'YData', pivot_y + pendulum_y);
    
    drawnow;
    pause(0.01);
end