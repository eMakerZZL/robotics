clc;
clear;
close;
%alpha a theta d
L1_DH = [0       , 0 ,       0 , 2];
L2_DH = [-pi / 2 , 2 , -pi / 2 , 2];
L3_DH = [-pi / 2 , 2 ,       0 , 2];
L4_DH = [0       ,-2 ,      pi , 0];

rotate_alpha = @(alpha) trotx(alpha);
rotate_theta = @(theta) trotz(theta);
parallel_a   = @(a) transl(a,0,0);
parallel_d   = @(d) transl(0,0,d);

Fkine = @(DHTbl) rotate_alpha(DHTbl(1)) * parallel_a(DHTbl(2)) * rotate_theta(DHTbl(3)) * parallel_d(DHTbl(4));
Ikine = @(DHTbl) inv(Fkine(DHTbl));

Fkined = @(DHTbl,d) rotate_alpha(DHTbl(1)) * parallel_a(DHTbl(2)) * rotate_theta(DHTbl(3)) * parallel_d(DHTbl(4) + d);
Ikined = @(DHTbl,d) inv(Fkined(DHTbl,d));

drawLine = @(points) line(points(:,1),points(:,2),points(:,3));
showFrame = @(frame,id) trplot(frame, 'frame', id, 'rviz');

Frame_Base = eye(4);
Frame_L1   = Frame_Base * Fkine(L1_DH);
Frame_L2   = Frame_L1   * Fkine(L2_DH);
Frame_L3   = Frame_L2   * Fkine(L3_DH);
Frame_L4   = Frame_L3   * Fkine(L4_DH);

r = 5;
theta = linspace(0, 2 * pi, 100);

circle_x = 5 + r * cos(theta);
circle_y = 5 + r * sin(theta);
circle_z = 5 * ones(size(theta));
circle = [circle_x',circle_y',circle_z'];

cur_pos = transl(Frame_L4);
dst_pos = circle(1,:);

dx = dst_pos(1) - cur_pos(1);
dy = dst_pos(2) - cur_pos(2);
dz = dst_pos(3) - cur_pos(3);

work_pos = [linspace(cur_pos(1),dst_pos(1),100)',linspace(cur_pos(2),dst_pos(2),100)',linspace(cur_pos(3),dst_pos(3),100)'];

d1 = work_pos(:,3) - L3_DH(2) - L4_DH(2) - L1_DH(4);
d2 = work_pos(:,2) - L2_DH(4);
d3 = work_pos(:,1) - L1_DH(2) -  L2_DH(2) - L3_DH(4);

for i = 1 : 100
    Frame_L1   = Frame_Base * Fkined(L1_DH,d1(i));
    Frame_L2   = Frame_L1   * Fkined(L2_DH,d2(i));
    Frame_L3   = Frame_L2   * Fkined(L3_DH,d3(i));
    Frame_L4   = Frame_L3   * Fkine(L4_DH);

    showFrame(Frame_Base, 'Base');
    hold on;
    showFrame(Frame_L1,'L1');
    showFrame(Frame_L2,'L2');
    showFrame(Frame_L3,'L3');
    showFrame(Frame_L4,'L4');

    drawArrow(Frame_Base,Frame_L1);
    drawArrow(Frame_L1,Frame_L2);
    drawArrow(Frame_L2,Frame_L3);
    drawArrow(Frame_L3,Frame_L4);

    axis([0 10 0 10 0 10]);
    hold off;
    getframe;
end

for i = 1 : 100
    d1 = circle(i,3) - L3_DH(2) - L4_DH(2) - L1_DH(4);
    d2 = circle(i,2) - L2_DH(4);
    d3 = circle(i,1) - L1_DH(2) -  L2_DH(2) - L3_DH(4);

    Frame_L1   = Frame_Base * Fkined(L1_DH,d1);
    Frame_L2   = Frame_L1   * Fkined(L2_DH,d2);
    Frame_L3   = Frame_L2   * Fkined(L3_DH,d3);
    Frame_L4   = Frame_L3   * Fkine(L4_DH);

    showFrame(Frame_Base, 'Base');
    hold on;
    showFrame(Frame_L1,'L1');
    showFrame(Frame_L2,'L2');
    showFrame(Frame_L3,'L3');
    showFrame(Frame_L4,'L4');

    drawArrow(Frame_Base,Frame_L1);
    drawArrow(Frame_L1,Frame_L2);
    drawArrow(Frame_L2,Frame_L3);
    drawArrow(Frame_L3,Frame_L4);

    plot3(circle(1:i,1),circle(1:i,2),circle(1:i,3));

    axis([0 10 0 10 0 10]);
    hold off;
    getframe;
end
