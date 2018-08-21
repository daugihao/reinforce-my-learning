function [s,r] = env_nArmedBandit(a)
%ENV_NARMEDBANDIT environment to respond to an (a)ction with a new (s)tate and a
%(r)eward

global env;

% For the n-armed bandit example, the state does not vary with time
s = 0;

prob_win = env.prob(a);
if rand < prob_win
    r = env.reward(1);
else
    r = env.reward(2);
end

end

