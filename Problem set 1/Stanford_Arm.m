clc;
clear;
close all;

% DH parameters 
DH_params = [
    0,      -pi/2,  1.3,    0;    % Link 1
    0,      -pi/2,  1.4,    0;    % Link 2
    0,      0,      0,      -pi/2;% Link 3 (Prismatic Joint)
    0,      -pi/2,  0.9,    0;    % Link 4
    0,      pi/2,   0,      0;    % Link 5
    0,      -pi/2,  0.4,    0     % Link 6
];

% 조인트 타입 정의 ('R' for Revolute, 'P' for Prismatic)
joint_types = ['R', 'R', 'P', 'R', 'R', 'R'];

% 비디오 생성 
video = VideoWriter('6DOF_Manipulation(Stanford_Arm).avi');
video.FrameRate = 10;
open(video);

figure('Position', [100, 100, 1200, 800]);
axis([-5, 5, -5, 5, -1, 7]);
grid on;
view(3);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('6 DOF Manipulator (Stanford Arm)');
hold on;


% Set base position
plot3(0, 0, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

% link and joint array
num_links = size(DH_params, 1);
hLinks = gobjects(num_links, 1);
hJoints = gobjects(num_links+1, 1); 

for i = 1:num_links
    hLinks(i) = plot3([0, 0], [0, 0], [0, 0], 'LineWidth', 3);
    hJoints(i+1) = plot3(0, 0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
end

hJoints(1) = plot3(0, 0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
colors = lines(num_links);

for t = 0:0.1:30
    theta = [
        pi/18 * t;           % Joint 1 (Revolute)
        pi/6 * t;       % Joint 2 (Revolute)
        -pi/2;               % Joint 3 (Prismatic, theta 고정)
        pi/12 * t;    % Joint 4 (Revolute)
        pi/15 * sin(4*t);    % Joint 5 (Revolute)
        pi/6 * t     % Joint 6 (Revolute)
    ];
    
    % d 값 업데이트 (Prismatic joint)
    d = [
        DH_params(1, 3);     % Joint 1
        DH_params(2, 3);     % Joint 2
        0.5 + 0.5 * sin(t);  % Joint 3 (Prismatic)
        DH_params(4, 3);     % Joint 4
        DH_params(5, 3);     % Joint 5
        DH_params(6, 3);     % Joint 6
    ];
    
    % 각 link에 대한 계산
    T = eye(4);
    positions = zeros(num_links+1, 3); % 각 조인트의 위치를 저장
    positions(1, :) = [0, 0, 0]; % base position
    
    for i = 1:num_links
        % 현재 링크의 DH 파라미터
        a = DH_params(i, 1);
        alpha = DH_params(i, 2);
        % joint_types에 따라 θ 또는 d 값을 업데이트
        if joint_types(i) == 'R' % 회전 조인트인 경우
            theta_i = theta(i) + DH_params(i, 4);
            d_i = DH_params(i, 3);
        elseif joint_types(i) == 'P' % 프리스매틱 조인트인 경우
            theta_i = DH_params(i, 4);
            d_i = d(i); 
        end
        
        A = DH_Convention(theta_i, d_i, a, alpha);
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
