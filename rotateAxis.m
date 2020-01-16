clear all;
close all;
clc;

hold on;
axis square;
grid on;
view(3);

theta = linspace(0, 2 * pi, 100);
radius = 10;
height = 50;

x = zeros(1, length(theta));
y = radius * cos(theta);
z = radius * sin(theta);

X = [x; height * ones(1, length(theta))];
Y = repmat(y,2,1);
Z = repmat(z,2,1);

% mesh(X,Y,Z);
clear X Y Z;

n = 5;
x = n / 2 * pi * theta;
plot3(x,y,z,'ro');

v1 = [x; y; z]';
v2 = circshift(v1,1);

v1(1,:) = [];
v2(1,:) = [];
arrow3(v1, v2, 'r');

vec1 = v2 - v1;
vec2 = zeros(size(vec1));
vec2(:,1) = height;

vec3 = cross(vec1, -vec2);

% for i = 1 : length(vec3)
%     vec3(i,:) = vec3(i,:) / norm(vec3(i,:)) * (radius + 5);
% end

% v1 = circshift(v1,-1);
arrow3(v1, vec3);
