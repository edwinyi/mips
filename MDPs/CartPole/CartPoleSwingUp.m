classdef CartPoleSwingUp < CartPoleEnv
% Cart-pole with discrete actions.
% The goal is to swing up and balance the pole starting from a random position.
% The episode ends if the cart goes out of bounds.

    properties
        % MDP variables
        dstate = 4;
        daction = 1;
        dreward = 1;
        isAveraged = 0;
        gamma = 0.99;

        % Bounds : state = [x xd theta thetad])
        stateLB = [-3, -inf, -pi, -inf]';
        stateUB = [3, inf, pi, inf]';
        actionLB = 1;
        actionUB = 2;
        rewardLB = -1;
        rewardUB = 0;

        % Finite actions
        allactions = [-CartPoleEnv.force CartPoleEnv.force];
    end
    
    methods
        function state = init(obj, n)
            state = myunifrnd([-1,-2,pi-1,-3],[1,2,pi+1,3],n);
        end
        
        function action = parse(obj, action)
            action = obj.allactions(action);
        end
            
        function reward = reward(obj, state, action, nextstate)
            reward = cos(nextstate(3,:)) - 1;
            reward(obj.isterminal(nextstate)) = -100;
        end
        
        function absorb = isterminal(obj, state)
            absorb = state(1,:) < obj.stateLB(1) | state(1,:) > obj.stateUB(1);
        end
    end
 
end