clc;
clear;
close;
%theta d a alpha
L1_DH = [0       , 0 , 0 , 0       , 1];
L2_DH = [-pi / 2 , 0 , 5 , -pi / 2 , 1];
L3_DH = [0       , 0 , 5 , -pi / 2 , 1];

L1 = Link(L1_DH , 'modified');
L2 = Link(L2_DH , 'modified');
L3 = Link(L3_DH , 'modified');

bot = SerialLink([L1 L2 L3]);
w = [0 50 0 50 0 50];

q0 = eye(4);
q1 = q0;
q1(1,4) = 10;
q1(2,4) = 30;
q1(3,4) = 30;

rotate_alpha = @(alpha) trotx(alpha);
rotate_theta = @(theta) trotz(theta);
parallel_a   = @(a) transl(a,0,0);
parallel_d   = @(d) transl(0,0,d);

Fkine = @(v,d) parallel_d(d) * rotate_theta(v(1)) * parallel_a(v(3)) * rotate_alpha(v(4));
ToolFKine = @(d) Fkine(L3_DH,d(3)) * Fkine(L2_DH,d(2)) * Fkine(L1_DH,d(1));

nsteps = 20;
posture_frame  = ctraj(q0,q1, nsteps);
position_frame = transl(posture_frame);
tool_frame = zeros(nsteps,3);

for i = 1 : nsteps
    tool_frame(i,:) = transl(ToolFKine(position_frame(i,:)));
end

for i = 1 : nsteps
     plot3(tool_frame(1:i,3),tool_frame(1:i,2),tool_frame(1:i,1));
     bot.plot(position_frame(i,:),'workspace',w);
end

