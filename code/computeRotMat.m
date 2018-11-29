% 16-741 Mechanics of Manipulation, Fall 2015
% Author: Sung Kyun Kim (kimsk@cs.cmu.edu)
%
% n: inward-pointing direction of a contact normal [nx; ny; nz]; 3x1 vector
% R: a rotation matrix with positive x-axis aligned with n; 3x3 matrix
%
% NOTE: As only one direction vector is specified, there is one redundant degree of freedom in the determination of R

function [R] = computeRotMat(n)

% write your code here
xv = [1, 0, 0];

crossP = cross(xv, n);
sineP = norm(crossP);
cosP = dot(xv, n);

skewV = [0, -crossP(3), crossP(2);
         crossP(3), 0, -crossP(1);
         -crossP(2), crossP(1), 0];

R = eye(3) + skewV + skewV * skewV * ((1 - cosP) / sineP^2);

end