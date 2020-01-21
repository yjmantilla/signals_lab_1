import matplotlib.pyplot as plt
from scipy import signal as signal
import numpy as np

def rect(t,width):
    return np.piecewise(t, [np.logical_or(t < -0.5*width,t > width *0.5), np.logical_and(t >= width*-0.5,t <= width*0.5)], [0, 1])
    #return np.piecewise(t, [t < 0, t >= 0], [-1, 1])

def step(t):
    return np.piecewise(t, [t < 0, t >= 0], [0, 1])

def manchester(t,w):
    return rect(t+w/2,w) - rect(t-w/2,w)
a=-5
b=5
inte = b-a
fs = 10000
t = np.linspace(a, b, fs, endpoint=False)
f = rect(t,6)
h = rect(t-1,2)*t
plt.plot(t,f,t,h)
plt.show()

g = np.convolve(f,h,'same')*inte/fs
l = signal.fftconvolve(f,h,'same')*inte/fs
plt.plot(t,g)
plt.show()

# why the fuck multiply by int/fs i have no idea...

plt.plot(t,l)
plt.show()

man1 = manchester(t-1,1)
man2 = -1*manchester(t-1,1)
plt.plot(t,man1)
plt.show()

plt.plot(t,man2)
plt.show()

manc1 = np.convolve(man1,man2,'same')*inte/fs

plt.plot(t,manc1)
plt.show()

manc2 = np.correlate(man1,man2,'same')*inte/fs

plt.plot(t,manc2)
plt.show()