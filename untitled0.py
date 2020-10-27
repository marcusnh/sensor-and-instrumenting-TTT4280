#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May  3 13:25:39 2020

@author: marcusnotohansen
"""

import matplotlib.pyplot as plt
import numpy as np



f=lambda x,k:1/(k/(x**2)-1)
x=np.linspace(-100,100)
k=10
y=f(x,k)
y2=np.log10(y)


fig,ax=plt.subplots(2,1)

ax[0].set_title("plot y = f(x,a)")
ax[0].plot(x,y) # .. "plot f"

ax[1].set_title("plot np.log10(y)")
ax[1].plot(x,y2) # .. "plot logarithm of f"

plt.show()