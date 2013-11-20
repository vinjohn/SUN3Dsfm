function [T, Jx, Jy, Jz] = icp_3d_err_transformed(p, D)

% ICP_3D_ERR    Error function for icp3d
% In:
%               p 7x1 params
%               D Nx3 data points
% Out:
%               T Nx3 transformed data points R(q(p1..4)) * (D + p(5:7))
%               Jx Nx7 jacobian dT(1)/dp
%               Jy Nx7 jacobian dT(2)/dp
%               Jz Nx7 jacobian dT(3)/dp

% Author: Andrew Fitzgibbon <awf@robots.ox.ac.uk>
% Date: 31 Aug 01

compute_jacobian = nargout > 1;

p1 = p(1);
p2 = p(2);
p3 = p(3);
p4 = p(4);
p5 = p(5);
p6 = p(6);
p7 = p(7);

n = size(D,1);
 %T = ones(n, 3);

if compute_jacobian
  %Jx = ones(n, 7);
  %Jy = ones(n, 7);
  %Jz = ones(n, 7);
end

D_1 = D(:,1);
D_2 = D(:,2);
D_3 = D(:,3);

t1 = p4.*p4;
t2 = p1.*p1;
t3 = p2.*p2;
t4 = p3.*p3;
t5 = t1+t2-t3-t4;
t6 = t2+t3+t4+t1;
t7 = 1/t6;
t8 = t5.*t7;
t9 = D_1+p5;
t11 = p1.*p2;
t12 = p4.*p3;
t13 = t11+t12;
t14 = 2.0.*t13.*t7;
t15 = D_2+p6;
t17 = p3.*p1;
t18 = p4.*p2;
t19 = t17-t18;
t20 = 2.0.*t19.*t7;
t21 = D_3+p7;
t24 = p1.*t7;
t25 = t24.*t9;
t26 = t6.*t6;
t27 = 1/t26;
t28 = t5.*t27;
t29 = t9.*p1;
t31 = p2.*t7;
t32 = t31.*t15;
t33 = 2.0.*t13.*t27;
t34 = t15.*p1;
t36 = p3.*t7;
t37 = t36.*t21;
t38 = 2.0.*t19.*t27;
t39 = t21.*p1;
t42 = t31.*t9;
t43 = t9.*p2;
t45 = t24.*t15;
t46 = t15.*p2;
t48 = p4.*t7;
t49 = t48.*t21;
t50 = t21.*p2;
t53 = t36.*t9;
t54 = t9.*p3;
t56 = t48.*t15;
t57 = t15.*p3;
t59 = t24.*t21;
t60 = t21.*p3;
t63 = t48.*t9;
t64 = t9.*p4;
t66 = t36.*t15;
t67 = t15.*p4;
t69 = t31.*t21;
t70 = t21.*p4;
t73 = t11-t12;
t74 = 2.0.*t73.*t7;
t76 = t1-t2+t3-t4;
t77 = t76.*t7;
t79 = p2.*p3;
t80 = p4.*p1;
t81 = t79+t80;
t82 = 2.0.*t81.*t7;
t85 = 2.0.*t73.*t27;
t87 = t76.*t27;
t89 = 2.0.*t81.*t27;
t104 = t17+t18;
t105 = 2.0.*t104.*t7;
t107 = t79-t80;
t108 = 2.0.*t107.*t7;
t110 = t1-t2-t3+t4;
t111 = t110.*t7;
t114 = 2.0.*t104.*t27;
t116 = 2.0.*t107.*t27;
t118 = t110.*t27;

T(:,1) = t8.*t9+t14.*t15+t20.*t21;
T(:,2) = t74.*t9+t77.*t15+t82.*t21;
T(:,3) = t105.*t9+t108.*t15+t111.*t21;

if compute_jacobian
  Jx(:,1) = 2.0.*t25-2.0.*t28.*t29+2.0.*t32-2.0.*t33.*t34+2.0.*t37-2.0.*t38.*t39;
  Jx(:,2) = -2.0.*t42-2.0.*t28.*t43+2.0.*t45-2.0.*t33.*t46-2.0.*t49-2.0.*t38.*t50;
  Jx(:,3) = -2.0.*t53-2.0.*t28.*t54+2.0.*t56-2.0.*t33.*t57+2.0.*t59-2.0.*t38.*t60;
  Jx(:,4) = 2.0.*t63-2.0.*t28.*t64+2.0.*t66-2.0.*t33.*t67-2.0.*t69-2.0.*t38.*t70;
  Jx(:,5) = t8;
  Jx(:,6) = t14;
  Jx(:,7) = t20;

  Jy(:,1) = 2.0.*t42-2.0.*t85.*t29-2.0.*t45-2.0.*t87.*t34+2.0.*t49-2.0.*t89.*t39;
  Jy(:,2) = 2.0.*t25-2.0.*t85.*t43+2.0.*t32-2.0.*t87.*t46+2.0.*t37-2.0.*t89.*t50;
  Jy(:,3) = -2.0.*t63-2.0.*t85.*t54-2.0.*t66-2.0.*t87.*t57+2.0.*t69-2.0.*t89.*t60;
  Jy(:,4) = -2.0.*t53-2.0.*t85.*t64+2.0.*t56-2.0.*t87.*t67+2.0.*t59-2.0.*t89.*t70;
  Jy(:,5) = t74;
  Jy(:,6) = t77;
  Jy(:,7) = t82;

  Jz(:,1) = 2.0.*t53-2.0.*t114.*t29-2.0.*t56-2.0.*t116.*t34-2.0.*t59-2.0.*t118.*t39;
  Jz(:,2) = 2.0.*t63-2.0.*t114.*t43+2.0.*t66-2.0.*t116.*t46-2.0.*t69-2.0.*t118.*t50;
  Jz(:,3) = 2.0.*t25-2.0.*t114.*t54+2.0.*t32-2.0.*t116.*t57+2.0.*t37-2.0.*t118.*t60;
  Jz(:,4) = 2.0.*t42-2.0.*t114.*t64-2.0.*t45-2.0.*t116.*t67+2.0.*t49-2.0.*t118.*t70;
  Jz(:,5) = t105;
  Jz(:,6) = t108;
  Jz(:,7) = t111;
end

return

if 0
  % Derivation
  syms D_1 D_2 D_3 real
  syms p1 p2 p3 p4 p5 p6 p7 real
  
  D = [D_1;D_2;D_3];
  R = coolquat2mat([p1 p2 p3 p4]) / sum([p1 p2 p3 p4].^2);
  T = R .* (D + [p5 p6 p7]');
  J = jacobian(T, [p1 p2 p3 p4 p5 p6 p7]);
  ccode_opt([T J])
  
%  t1 = p4*p4;
%  t2 = p1*p1;
%  t3 = p2*p2;
%  t4 = p3*p3;
%  t5 = t1+t2-t3-t4;
%  t6 = t2+t3+t4+t1;
%  t7 = 1/t6;
%  t8 = t5*t7;
%  t9 = D_1+p5;
%  t11 = p1*p2;
%  t12 = p4*p3;
%  t13 = t11+t12;
%  t14 = 2.0*t13*t7;
%  t15 = D_2+p6;
%  t17 = p3*p1;
%  t18 = p4*p2;
%  t19 = t17-t18;
%  t20 = 2.0*t19*t7;
%  t21 = D_3+p7;
%  t24 = p1*t7;
%  t25 = t24*t9;
%  t26 = t6*t6;
%  t27 = 1/t26;
%  t28 = t5*t27;
%  t29 = t9*p1;
%  t31 = p2*t7;
%  t32 = t31*t15;
%  t33 = 2.0*t13*t27;
%  t34 = t15*p1;
%  t36 = p3*t7;
%  t37 = t36*t21;
%  t38 = 2.0*t19*t27;
%  t39 = t21*p1;
%  t42 = t31*t9;
%  t43 = t9*p2;
%  t45 = t24*t15;
%  t46 = t15*p2;
%  t48 = p4*t7;
%  t49 = t48*t21;
%  t50 = t21*p2;
%  t53 = t36*t9;
%  t54 = t9*p3;
%  t56 = t48*t15;
%  t57 = t15*p3;
%  t59 = t24*t21;
%  t60 = t21*p3;
%  t63 = t48*t9;
%  t64 = t9*p4;
%  t66 = t36*t15;
%  t67 = t15*p4;
%  t69 = t31*t21;
%  t70 = t21*p4;
%  t73 = t11-t12;
%  t74 = 2.0*t73*t7;
%  t76 = t1-t2+t3-t4;
%  t77 = t76*t7;
%  t79 = p2*p3;
%  t80 = p4*p1;
%  t81 = t79+t80;
%  t82 = 2.0*t81*t7;
%  t85 = 2.0*t73*t27;
%  t87 = t76*t27;
%  t89 = 2.0*t81*t27;
%  t104 = t17+t18;
%  t105 = 2.0*t104*t7;
%  t107 = t79-t80;
%  t108 = 2.0*t107*t7;
%  t110 = t1-t2-t3+t4;
%  t111 = t110*t7;
%  t114 = 2.0*t104*t27;
%  t116 = 2.0*t107*t27;
%  t118 = t110*t27;
%  T[0][0] = t8*t9+t14*t15+t20*t21;
%  T[0][1] = 2.0*t25-2.0*t28*t29+2.0*t32-2.0*t33*t34+2.0*t37-2.0*t38*t39;
%  T[0][2] = -2.0*t42-2.0*t28*t43+2.0*t45-2.0*t33*t46-2.0*t49-2.0*t38*t50;
%  T[0][3] = -2.0*t53-2.0*t28*t54+2.0*t56-2.0*t33*t57+2.0*t59-2.0*t38*t60;
%  T[0][4] = 2.0*t63-2.0*t28*t64+2.0*t66-2.0*t33*t67-2.0*t69-2.0*t38*t70;
%  T[0][5] = t8;
%  T[0][6] = t14;
%  T[0][7] = t20;
%  T[1][0] = t74*t9+t77*t15+t82*t21;
%  T[1][1] = 2.0*t42-2.0*t85*t29-2.0*t45-2.0*t87*t34+2.0*t49-2.0*t89*t39;
%  T[1][2] = 2.0*t25-2.0*t85*t43+2.0*t32-2.0*t87*t46+2.0*t37-2.0*t89*t50;
%  T[1][3] = -2.0*t63-2.0*t85*t54-2.0*t66-2.0*t87*t57+2.0*t69-2.0*t89*t60;
%  T[1][4] = -2.0*t53-2.0*t85*t64+2.0*t56-2.0*t87*t67+2.0*t59-2.0*t89*t70;
%  T[1][5] = t74;
%  T[1][6] = t77;
%  T[1][7] = t82;
%  T[2][0] = t105*t9+t108*t15+t111*t21;
%  T[2][1] = 2.0*t53-2.0*t114*t29-2.0*t56-2.0*t116*t34-2.0*t59-2.0*t118*t39;
%  T[2][2] = 2.0*t63-2.0*t114*t43+2.0*t66-2.0*t116*t46-2.0*t69-2.0*t118*t50;
%  T[2][3] = 2.0*t25-2.0*t114*t54+2.0*t32-2.0*t116*t57+2.0*t37-2.0*t118*t60;
%  T[2][4] = 2.0*t42-2.0*t114*t64-2.0*t45-2.0*t116*t67+2.0*t49-2.0*t118*t70;
%  T[2][5] = t105;
%  T[2][6] = t108;
%  T[2][7] = t111;

end