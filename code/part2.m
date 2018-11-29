% 16-741 Mechanics of Manipulation, Fall 2015
% Author: Sung Kyun Kim (kimsk@cs.cmu.edu)
%
% Execution script to test your code for Part 2
%
% FRIC: a flag which is false (or 0) for frictionless contact and true (or 1) for frictional contact; boolean

function part2(FRIC)

% check input arguments
if nargin ~= 1
	FRIC = false;
end


%% Create and draw a soccer ball

% make a class instance
ball = SoccerBall;

% draw an icosahedron
figure;
ball.drawBall;

% % get a single contact normal; but you probably need more
% iv = 20;
% ratio = ones(3,1)./3;
% [cp, cn] = ball.getContactNormal(iv, ratio);
num_sample = 10000;


%% Find a force closure grasp
switch (FRIC)	% flag for contact condition
	
	case 0		% frictionless contact
		
        % unbounded when i < 7
		for i = 7:20
            found_flag = false;
            for j = 1:num_sample
                ivs = randperm(20, i);
                ratios = zeros(3, i);
                ratios(1:2, :) = rand(2, i);
                ratios(3, :) = ones(1, i) - ratios(1,:) - ratios(2,:);
                CP = zeros(3, i);
                CN = zeros(3, i);
                for k = 1:i
                    iv = ivs(k);
                    ratio = ratios(:, k);
                    [cp, cn] = ball.getContactNormal(iv, ratio);
                    CP(:, k) = cp;
                    CN(:, k) = cn;
                end
                [W] = contactScrew(CP, CN);
                [bFC, zmax] = isForceClosure(W);
                if bFC == 1
                    found_flag = true;
                    break
                end
            end
            if found_flag
                N = i;
                break
            end
        end
		
		% draw contact screws
		drawContactScrew(CP, W);
		
		% print out results
		N
		CP
		W
		zmax
		
	case 1		% frictional contact
		
		% friction coefficient
		mu = 0.3;
		
		% the number of side facets of a linearized polyhedral friction cone
		M = 10;

		for i = 1:20
            found_flag = false;
            for j = 1:num_sample
                ivs = randperm(20, i);
                ratios = zeros(3, i);
                ratios(1:2, :) = rand(2, i);
                ratios(3, :) = ones(1, i) - ratios(1,:) - ratios(2,:);
                CP = zeros(3, i);
                CN = zeros(3, i);
                for k = 1:i
                    iv = ivs(k);
                    ratio = ratios(:, k);
                    [cp, cn] = ball.getContactNormal(iv, ratio);
                    CP(:, k) = cp;
                    CN(:, k) = cn;
                end
                [CPF, CNF] = frictionCone(CP, CN, mu, M);
                [WF] = contactScrew(CPF, CNF);
                [bFCF, zmaxF] = isForceClosure(WF);
                if bFCF == 1
                    found_flag = true;
                    break
                end
            end
            if found_flag
                N = i;
                break
            end
        end
		
		% draw contact screws
		drawContactScrew(CPF, WF, M);
		
		% print out results
		N
		CP
		zmaxF
		
end
