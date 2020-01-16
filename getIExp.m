clear;
clc;
syms d1 d2 d3 d4 a1 a2 a3 a4 id1 id2 id3;  
L1_DH = [0       , a1 ,       0 , id1];
L2_DH = [-pi / 2 , a2 , -pi / 2 , id2];
L3_DH = [-pi / 2 , a3 ,       0 , id3];
L4_DH = [0       , a4 ,      pi , 0];

rotate_alpha = @(alpha) trotx(alpha);
rotate_theta = @(theta) trotz(theta);
parallel_a   = @(a) transl(a,0,0);
parallel_d   = @(d) transl(0,0,d);

Fkine = @(DHTbl) rotate_alpha(DHTbl(1)) * parallel_a(DHTbl(2)) * rotate_theta(DHTbl(3)) * parallel_d(DHTbl(4));
Ikine = @(DHTbl) inv(Fkine(DHTbl));

Fkined = @(DHTbl,d) rotate_alpha(DHTbl(1)) * parallel_a(DHTbl(2)) * rotate_theta(DHTbl(3)) * parallel_d(DHTbl(4) + d);
Ikined = @(DHTbl,d) inv(Fkined(DHTbl,d));

Frame_Base = eye(4);
Frame_L1   = Frame_Base * Fkined(L1_DH,d1)
Frame_L2   = Frame_L1   * Fkined(L2_DH,d2)
Frame_L3   = Frame_L2   * Fkined(L3_DH,d3)
Frame_L4   = Frame_L3   * Fkine(L4_DH)
