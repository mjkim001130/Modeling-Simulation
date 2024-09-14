clc;
clear;
close all;

hfig = figure(20);
grid on;
axis([-10, 50, -50, 50, -5, 50])

view(3);
hold on;

x = 0;
y = 0;
z = 0;
vx = 0.3;
vy = 0;
vz = 0.4;

hMyCar = plot3(x, y, z, 'o', 'MarkerEdgeColor', 'k', ...
    'MarkerFaceColor', 'r', 'MarkerSize', 18);

set(hMyCar, 'XData', x, 'YData', y, 'ZData', z);

T = 20;

video = VideoWriter('MovingBall.avi');
video.FrameRate = 20; 
open(video); 

for t = 1:0.1:T
    x = x + vx;
    y = y + vy;
    z = z + vz * sin(t);
    
    % Update the car's position in the plot
    set(hMyCar, 'XData', x, 'YData', y, 'ZData', z);
    
    % Capture the current frame for the video
    frame = getframe(gcf);
    writeVideo(video, frame);
    
    pause(0.05);
    drawnow;
end

% Close the video writer
close(video);
