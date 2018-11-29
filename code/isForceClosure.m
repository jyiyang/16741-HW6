% 16-741 Mechanics of Manipulation, Fall 2015
% Author: Sung Kyun Kim (kimsk@cs.cmu.edu)
%
% W: a set of normalized contact screws [[cix; ciy; ciz; c0ix; c0iy; c0iz] ...]; 6x(NM) matrix
% bFC: a flag which is true if the grasp is force closure; boolean
% zmax: the maximum value of the objective function at the optimal point; scalar

function [bFC, zmax] = isForceClosure(W)

if rank(W) < 6
    bFC = false;
    zmax = Inf;
else
    P = sum(W, 2) / size(W, 2);
    Wp = W - P;
    [x, zmax] = linprog(P, Wp', ones(size(W, 2), 1));

    zmax = -zmax;
    if zmax < 1
        bFC = true;
    else
        bFC = false;
    end
end

end
% write your code here
