clc; clear; close all;

%% Define the mass-spring-damper system
function xdot = mds_ss(t,x)
    m = 1; c = 0.2; k = 5; u = 0;
    A = [0, 1;
        -k/m, -c/m];
    B = [0; 1/m];
    xdot = A*x + B*u;
end

%% Time span
t0 = 0; tf = 50;
tspan = [t0, tf];

%% Initial conditions [position; velocity]
x0 = [1.3; 0];

%% Solve ODE
[t, x] = ode45(@mds_ss, tspan, x0);

%% Plot
figure;
set(gcf, 'Position', [100, 100, 1200, 500]); % Set window size to accommodate both plots

% Mass-Spring-Damper sys simulation
subplot('Position', [0.05, 0.1, 0.45, 0.8]); % Position for the first plot (x, y, width, height)
grid on;
axis equal
axis([-1, 2, -1, 1]);
hold on;
xlabel('Position');
title('Mass-Spring-Damper System Simulation');

wall_x = [0, 0];
wall_y = [-0.5, 0.5];
plot(wall_x, wall_y, 'k', 'LineWidth', 20);

% Parameters for mass
ball_radius = 0.1;

% Draw the initial ball position
ball_x = x(1,1); % initial position from ODE solution (Position at initial time)
h_mass = rectangle('Position',[ball_x - ball_radius, -ball_radius, 2*ball_radius, 2*ball_radius],...
    'Curvature',[1,1],'FaceColor','r');

% Draw the initial spring
h_spring = plot([0, ball_x - ball_radius], [0, 0], 'b', 'LineWidth', 2);

% Phase plot
subplot('Position', [0.55, 0.1, 0.4, 0.8]); % Position for the second plot (x, y, width, height)
plot(x(:,1), x(:,2));
xlabel('x (Position)');
ylabel('xdot (Velocity)');
title('Phase Plot');
grid on;

% Animation 
for i = 1:length(t)
    % Update ball position 
    subplot('Position', [0.05, 0.1, 0.45, 0.8]); 
    ball_x = x(i,1);
    
    % Update mass (red ball)
    set(h_mass, 'Position', [ball_x - ball_radius, -ball_radius, 2*ball_radius, 2*ball_radius]);
    
    % Update spring
    set(h_spring, 'XData', [0, ball_x - ball_radius], 'YData', [0, 0]);
    
    drawnow;
    pause(0.01);
end
