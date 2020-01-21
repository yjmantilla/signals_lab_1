import numpy as np

def db_to_watts(pow,p_ref,scale):
    return p_ref * (10**(pow/10))*10**(-scale)

def pow_to_volts(pow,res,scale):
    return np.sqrt(pow*res)*10**(-scale)

def vol_to_dbv(v,vref):
    return 20*np.log10(v/vref)

def calc(pow,scaleP,scaleV):
    p1 = db_to_watts(pow,10**-3,scaleP)
    v1 = pow_to_volts(p1*10**(scaleP),50,scaleV)
    v1db = vol_to_dbv(v1*10**scaleV,10**-3)
    return p1,pow,v1,v1db

def analyzer(pow):
    return calc(pow,-6,-3)

def voltage_to_pow(v,r,scaleW,scaleV):
    v1 = v*(10**scaleV)
    return 10**(-scaleW)*(v1**2)/r 

def pow_to_dbm(pow,pow_ref):
    return 10*np.log10(pow/pow_ref)
def oscilloscope(v,r):
    vdbv = vol_to_dbv(v*10**-3,10**-3)
    pow = voltage_to_pow(v,r,-6,-3)
    powdb = pow_to_dbm(pow*10**-6,10**-3)
    return pow,powdb,v,vdbv


#print(analyzer(-11.2))
zosc = 10* (10**(6))
print('tabla1.1')
print(oscilloscope(226,zosc))
print(analyzer(-11.2))

print('tabla2')
print(oscilloscope(225.34,zosc))
print(analyzer(-8.4))

print('tabla3')
print(oscilloscope(71.31,zosc))
print(analyzer(-18.52))

print('tabla4')
print(oscilloscope(127.95,zosc))
print(analyzer(-9.7))

print('tabla5')
print(oscilloscope(40.84,zosc))
print(analyzer(-20.23))