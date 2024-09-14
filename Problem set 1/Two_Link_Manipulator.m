clc;
clear;
close all;

% DH parameters
a_1 = 0;
alpha_1 = pi/2;
d_1 = 5; % link1's length
theta_1 = 0;

a_2 = 15; % link2's length
alpha_2 = 0;
d_2 = 0;
theta_2 = 0;

DH_params = [
    0, pi/2, 5, 0; % Link 1
    15, 0, 0, 0
];

video = VideoWriter('Two_Link_Manipulation.avi'); 
video.FrameRate = 10; 
open(video); 

figure;
axis([-20, 20, -20, 20, -5, 15]); 
grid on; 
view(3); 
xlabel('X');
ylabel('Y');
zlabel('Z');
title('2 Link Manipulator');
hold on;

% set base position
plot3(0, 0, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

% link and joint array
num_links = size(DH_params, 1);
hLinks = gobjects(num_links, 1);
hJoints = gobjects(num_links+1, 1);

hLink1 = plot3([0, 0], [0, 0], [0, 0], 'r', 'LineWidth', 3); % Link 1
hLink2 = plot3([0, 0], [0, 0], [0, 0], 'b', 'LineWidth', 3); % Link 2
hJoint1 = plot3(0, 0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k'); % Joint 1
hJoint2 = plot3(0, 0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k'); % Joint 2

for i = 1:num_links
    hLinks(i) = plot3([0, 0], [0, 0], [0, 0], 'LineWidth', 3);
    hJoints(i+1) = plot3(0, 0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
end

hJoints(1) = plot3(0, 0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
colors = lines(num_links);

for t = 0:0.1:20
    theta = [
        pi/18 * t;
        pi/6 * sin(t);
    ];
    
   % 각 link에 대한 계산
    T = eye(4);
    positions = zeros(num_links+1, 3); % 각 조인트의 위치를 저장
    positions(1, :) = [0, 0, 0]; % base position
    for i = 1:num_links
        % 현재 링크의 DH 파라미터
        a = DH_params(i, 1);
        alpha = DH_params(i, 2);
        d = DH_params(i, 3);
        theta_i = theta(i) + DH_params(i, 4); % 기본 theta 값에 t만큼 변화
        
        A = DH_Convention(theta_i, d, a, alpha);
        T = T * A;
        
        % 현재 조인트 위치 저장
        positions(i+1, :) = T(1:3, 4)';
    end
    
    % 링크와 조인트 업데이트
    for i = 1:num_links
        set(hLinks(i), 'XData', positions(i:i+1, 1), 'YData', positions(i:i+1, 2), 'ZData', positions(i:i+1, 3), 'Color', colors(i, :));
        set(hJoints(i+1), 'XData', positions(i+1, 1), 'YData', positions(i+1, 2), 'ZData', positions(i+1, 3));
    end
    
    drawnow;
    
    % 비디오 저장 
    frame = getframe(gcf);
    writeVideo(video, frame);
    
    pause(0.1);
end

% 비디오 저장 종료 
close(video);
