clear
close all
clc

%the length of the actuator is set equal to 2. All lengths are normalized
%with respect to half of the length of the actuator. Therefore, x ranges in
%the interval [0,1]. xe belongs to the same interval.

global angle_halfpleat offset
%independent parameters:
number_pleats = 6; %THIS IS THE NUMBER OF PLEATS IN THE GRACE
angle_halfpleat = 0.5*(2*pi)/number_pleats;
offset = 0.25; %radius at the end sections of the actuators

aM1 = 0.38;
aM2 = 0.2;
am2 = 0.15;
dist2 = 0.57;

%compute am1 and dc1:
am1 = dist2*cos(pi/2 - angle_halfpleat) - am2*cos(angle_halfpleat);
dist1 = dist2*sin(pi/2 - angle_halfpleat) + am2*sin(angle_halfpleat);


%parabolic profiles
n = 30;
x = linspace(0,1,n*3);
t1 = 0.7;
b1 = 0.28;
t2 = t1 + dist1 + aM1 - offset;
b2 = b1 + dist2 - aM2 - offset;

while 0.5*t2/t1<1
    t1 = 0.92*t1
    t2 = t1 + dist1 + aM1 - offset
end
while 0.5*b2/b1<1
    b1 = 0.92*b1
    b2 = b1 + dist2 - aM2 - offset
end

if 0.5*b2/b1<1 || 0.5*t2/t1<1
    disp('warning! Check parabolic profiles')
end

ytopi = -t1*x.^2 + t2*x;
yboti = -b1*x.^2 + b2*x;

%obtain profile of the "edge"
%final point:
yf_edge = norm([dist1, am1]) - offset;
%parabola:
g1 = 0.5*(t1+b1);
g2 = g1 + yf_edge;
while 0.5*g2/g1<1
    g1 = 0.92*g1;
    g2 = g1 + yf_edge;
end
yedgei = -g1*x.^2 + g2*x;


plot (x, ytopi)
hold on
plot (x, yboti)
plot (x, yedgei)
hold off
legend ('ytopi', 'yboti', 'yedgei' , 'x')

