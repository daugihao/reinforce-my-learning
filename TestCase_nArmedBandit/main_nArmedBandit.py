import numpy as np
import matplotlib.pyplot as plt
from TestCase_nArmedBandit import agent_nArmedBandit
from TestCase_nArmedBandit import env_nArmedBandit

plt.close('all')

NBandits = 8
stepsize = 0.01
randseed = 8
epsilon = 0.05

Iterations = 1000

agent = agent_nArmedBandit.Agent(NBandits, stepsize, epsilon)
env = env_nArmedBandit.Env(NBandits, randseed)

a = np.zeros(Iterations, 'int')
r = np.zeros(Iterations, 'int')

# Run through iterations
a[0] = agent.learn_and_act()
for i in range(0, (Iterations-2)):
    r[i] = env.payout(a[i])
    a[i+1] = agent.learn_and_act(r[i], a[i])
r[Iterations-1] = env.payout(a[Iterations-1])

# Visualise the results
print(env.prob)
print(agent.actionvalue)

plt.figure(0)
plt.bar(range(1, len(agent.actionvalue)+1), agent.actionvalue)
plt.title("Inferred Value Per Action", fontsize=24)
plt.xlabel("Action", fontsize=18)
plt.ylabel("Inferred Value", fontsize=18)

plt.figure(1)
plt.bar(range(1, len(env.prob)+1), env.prob)
plt.title("True Value Per Action", fontsize=24)
plt.xlabel("Action", fontsize=18)
plt.ylabel("True Value", fontsize=18)
plt.show()
