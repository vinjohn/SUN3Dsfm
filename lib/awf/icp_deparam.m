%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [R,t] = icp_deparam(p)

p1 = p(1);
p2 = p(2);
p3 = p(3);
p4 = p(4);
p5 = p(5);
p6 = p(6);
p7 = p(7);

R = coolquat2mat([p1 p2 p3 p4]) / sum([p1 p2 p3 p4].^2);
t = [p5 p6 p7]';