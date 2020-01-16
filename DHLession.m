clc;
clear;
close;
%alpha a theta d
L1_DH = [0       , 0 ,       0 , 2];
L2_DH = [-pi / 2 , 2 , -pi / 2 , 0];
L3_DH = [-pi / 2 , 2 ,       0 , 0];
L4_DH = [0       ,-2 ,      pi , 0];

rotate_alpha = @(alpha) trotx(alpha);
rotate_theta = @(theta) trotz(theta);
parallel_a   = @(a) transl(a,0,0);
parallel_d   = @(d) transl(0,0,d);

Fkine = @(DHTbl) rotate_alpha(DHTbl(1)) * parallel_a(DHTbl(2)) * rotate_theta(DHTbl(3)) * parallel_d(DHTbl(4));
Ikine = @(DHTbl) inv(Fkine(DHTbl));

Fkined = @(DHTbl,d) rotate_alpha(DHTbl(1)) * parallel_a(DHTbl(2)) * rotate_theta(DHTbl(3)) * parallel_d(DHTbl(4) + d);

drawLine = @(points) line(points(:,1),points(:,2),points(:,3));
showFrame = @(frame,id) trplot(frame, 'frame', id, 'rviz');

Frame_Base = eye(4);
Frame_L1   = Frame_Base * Fkine(L1_DH);
Frame_L2   = Frame_L1   * Fkine(L2_DH);
Frame_L3   = Frame_L2   * Fkine(L3_DH);
Frame_L4   = Frame_L3   * Fkine(L4_DH);

tool_sp = transl(Frame_L4);
tool_ep = tool_sp + 10;

d = linspace(0,10,100);
for i = 1 : 100
    Frame_L1   = Frame_Base * Fkined(L1_DH,d(i));
    Frame_L2   = Frame_L1   * Fkined(L2_DH,d(i));
    Frame_L3   = Frame_L2   * Fkined(L3_DH,d(i));
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

    axis([0 20 0 20 0 20]);
    hold off;
    f(:,i) = getframe;
end
movie(f,1,10);
