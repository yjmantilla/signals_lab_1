#libraries
import scipy.io as sio;
import matplotlib.pyplot as plt;
import numpy as np;
#import scipy.signal as siosig;
#import wfdb.io as wafo;

#functions
def haar_aproximation(signal):

    scale=[1/np.sqrt(2),1/np.sqrt(2)]
    scale=np.asarray(scale)

    aproximation=np.correlate(signal,scale,'full')
    aproximation=aproximation[1::2]
    #print(aproximation.shape)
    return aproximation

def haar_detail(signal):
    wavelet=[1/np.sqrt(2),-1/np.sqrt(2)]
    wavelet=np.asarray(wavelet)

    detail=np.correlate(signal,wavelet,'full')
    detail=detail[1::2];
    #print(detail.shape)
    return detail

def haar_inverse(haar_signal,char):
    inverse=np.zeros((2*haar_signal.shape[0],1))
    inverse=np.squeeze(inverse)
    inverse[0::2]=haar_signal
    if char == 'a':
        inverse[1::2]=haar_signal
    if char == 'd':
        inverse[1::2]=-1*haar_signal
    
    inverse=inverse*(1/np.sqrt(2))
    return inverse

def haar_compression(signal,N):
    aproximation=signal
    
    for x in range(0, N):
        aproximation2=aproximation #information was getting loss here lol
        aproximation=haar_aproximation(aproximation)
        detail=haar_detail(aproximation2)
        print(str(aproximation.shape)+str(detail.shape))    
    
    compression=aproximation
    loss=detail
    print("\n")
    accum=np.zeros((haar_inverse(loss,'d').shape[0],1))
    accum=np.squeeze(accum)
    for x in range(0, N):
        compression=haar_inverse(compression,'a')
        if x == 0:
            loss=haar_inverse(loss,'d')
        
        else:
            dummy=accum
            dummy2=accum
            accum=np.zeros((2*accum.shape[0],1))
            accum=np.squeeze(accum)
            accum[0::2]=dummy
            accum[1::2]=dummy2
            #loss2=np.zeros((2*loss.shape[0],1))
            #loss2=np.squeeze(loss2)
            #loss2[0::2]=loss
            #loss2[1::2]=loss
            loss=haar_inverse(loss,'d')
            accum=loss+accum
                
        #see what happens when you do it with the detail
        #print(str(compression.shape)+str(loss.shape))
        
    return (compression,loss,accum)


#loading of the ecg

#for wfdb files
#signals, fields = wafo.rdsamp(record_name, sampfrom=0, sampto='end', channels='all', pb_dir=None)

#raw_signal, fields = wafo.rdsamp('aami3a', sampfrom=0, sampto='end', channels='all', pb_dir=None)
#print("loaded fields are: " +str(fields));

#for mat files:
mat_contents=sio.loadmat('ecg.mat')
print("loaded fields are: " +str(mat_contents.keys()));

#the field of interest is 'ecg'
#for the wfdb signal is already that field

#for mat:
raw_signal=mat_contents['ecg'];

signal=np.squeeze(raw_signal);

#preliminary visualization of the signal
print("original signal and size");
print(signal.shape);
print("average: "+str(np.mean(signal)))
plt.plot(signal);
plt.show();

#comparison between level of compression of the signal    
N=7

for x in range(1,N+1):
    (compression,loss,accum)=haar_compression(signal,x)
    print("compression level: "+str(x));
    #print(str(compression.shape)+str(loss.shape));
    plt.plot(compression);
    plt.show();
    plt.plot(loss);
    plt.show()

plt.plot(accum)    
#intuition: as N increases the compression tends to the average of the signal
#actually i dont think that is true
#problem , the array gets bigger and bigger each iteration

