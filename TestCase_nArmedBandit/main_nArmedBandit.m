clear all;
close all;
clc;

global env;
global agent;

% Initialise variables for the problem
env.NBandits = 8;
randSeed = 20;
NIters = 10000;

% Initialise the environment parameters
rng(randSeed);
env.prob = rand(env.NBandits,1);
env.reward = [1 0];

agent.actionvalue = ones(env.NBandits,1);
agent.stepsize = 0.01;

a = zeros(NIters,1);
r = zeros(NIters,1);

% Run through iterations
a(1) = agent_nArmedBandit();
for i = 1:NIters-1
    [~,r(i)] = env_nArmedBandit(a(i));
    a(i+1) = agent_nArmedBandit(0,r(i),a(i));
end
[~,r(NIters)] = env_nArmedBandit(a(NIters));

% Plot results
figure;
subplot(2,2,1);
plot(1:length(a),a,'b*');
grid on;
xlabel('Iteration Number');
ylabel('Action Selected');

subplot(2,2,2);
plot(1:length(r),r,'r*');
grid on;
xlabel('Iteration Number');
ylabel('Reward Received');

subplot(2,2,3);
bar([env.prob agent.actionvalue])
grid on;
xlabel('Action');
ylabel('Action-Value');
legend('True','Inferred');

subplot(2,2,4);
avlength = 100;
for i = avlength:avlength:length(r)
    avtime(round(i/avlength)) = i;
    avval(round(i/avlength)) = mean(r(i-(avlength-1):i));
end
hold on;
grid on;
plot([0 NIters],[max(env.prob)*env.reward(1) max(env.prob)*env.reward(1)],'b--');
plot([0 NIters],[env.reward(1) env.reward(1)],'b-');
plot(avtime,avval);
xlabel('Iteration Number');
ylabel(['Averaged Reward (' num2str(avlength) ' tests)']);
legend('Average Reward','Average Maximum Reward','Absolute Maximum Reward');