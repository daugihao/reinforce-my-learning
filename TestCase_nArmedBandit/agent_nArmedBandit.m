function [a] = agent_nArmedBandit(~,r,a)
%AGENT_NARMEDBANDIT agent to determine an (a)ction for the current (s)tate

global env;
global agent;

policy = 1;

switch nargin
    case 0
        a = randi([1 env.NBandits]);
    case 3
        % Update action-value function
        agent.actionvalue(a) = agent.actionvalue(a) + agent.stepsize*(r - agent.actionvalue(a));
        
        % Choose next action
        switch policy
            case 1 % Greedy (always choosing the maximum value with eps = 0)
                epsilon = 0.05;
                if rand >= epsilon
                    [~,a] = max(agent.actionvalue); 
                else
                    a = randi([1 env.NBandits],1);
                end
            case 2 % Sample directly from  the inferred probability distribution
                a = discretesample(agent.actionvalue,1);
            case 3 % Softmax approach based on a Gibbs distribution
                temperature = 0.5;
                prob = softmaxprob(agent.actionvalue,temperature);
                a = discretesample(prob,1);
            otherwise
                error('Unknown policy selected!');
        end
    otherwise
        error('Unknown number of arguments to function!');
end

end