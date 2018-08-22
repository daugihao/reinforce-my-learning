import numpy as np
import random


class Agent(object):
    def __init__(self, n, stepsize, epsilon):
        self.NBandits = n
        self.actionvalue = np.ones(n)
        self.stepsize = stepsize
        self.epsilon = epsilon

    def learn_and_act(self, *args):
        if len(args) == 0:
            a = random.randint(0, self.NBandits-1)
        elif len(args) == 2:
            self.actionvalue[args[1]] = self.actionvalue[args[1]] + self.stepsize * (args[0] - self.actionvalue[args[1]])
            if random.uniform(0, 1) >= self.epsilon:
                a = np.argmax(self.actionvalue)
            else:
                a = random.randint(0, self.NBandits-1)
        else:
            raise ValueError('action function called with incorrect number of arguments!')
        return a
