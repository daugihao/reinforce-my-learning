import numpy as np
import random


class Env(object):
    def __init__(self, n, randseed):
        random.seed(randseed)
        self.prob = np.array([random.uniform(0, 1) for _ in range(n)])
        self.reward = np.array([1, 0])

    def payout(self, action):
        prob_win = self.prob[action]
        if random.uniform(0, 1) < prob_win:
            r = self.reward[0]
        else:
            r = self.reward[1]
        return r
