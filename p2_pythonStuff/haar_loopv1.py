#libraries
import scipy.io as sio;
import matplotlib.pyplot as plt;
import numpy as np;
#import scipy.signal as siosig;
#import wfdb.io as wafo;

#functions
def haar_aproximation(signal):

    scale=[1/np.sqrt(2),1/np.sqrt(2)];
    scale=np.asarray(scale);

    aproximation=np.correlate(signal,scale,'full');
    aproximation=aproximation[1::2];
    return aproximation

def haar_detail(signal):
    wavelet=[1/np.sqrt(2),-1/np.sqrt(2)];
    wavelet=np.asarray(wavelet);

    detail=np.correlate(signal,wavelet,'full');
    detail=detail[1::2];
    return detail

def haar_inverse(haar_signal,char):
    inverse=np.zeros((2*haar_signal.shape[0],1));
    inverse=np.squeeze(inverse);
    inverse[0::2]=haar_signal;
    if char == 'a':
        inverse[1::2]=haar_signal;
    if char == 'd':
        inverse[1::2]=-1*haar_signal;
    
    inverse=inverse*(1/np.sqrt(2));
    return inverse

def haar_compression(signal,N):
    aproximation=signal

    for x in range(0, N):
        aproximation=haar_aproximation(aproximation)
        
    compression=aproximation

    for x in range(0, N):
        compression=haar_inverse(compression,'a')
    
    return compression


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
plt.plot(signal);
plt.show();

#definition of the signals of the transform:


#N=10;
#signals=np.zeros((N,signal.shape[0]+1));

#
#for x in range(0, N):
#    print(x);
#    aproximation=np.correlate(signal,scale,'full');
#    detail=np.correlate(signal,wavelet,'full');
#    aproximation=aproximation[1::2];
#    aproximation_inverse=np.zeros((2*aproximation.shape[0],1));
#    aproximation_inverse=np.squeeze(aproximation_inverse);
#    aproximation_inverse[0::2]=aproximation;
#    aproximation_inverse[1::2]=aproximation;
#    aproximation_inverse=aproximation_inverse*(1/np.sqrt(2));
#    signal_compression=aproximation_inverse;
#    print("lossy signal reconstruction:");
#    print(signal_compression.shape);
#    plt.plot(signal_compression);
#    plt.show();
#    signal=signal_compression;
#    signals[x,:]=signal_compression;
#    
N=10
for x in range(0,N):
    compression=haar_compression(signal,x)
    print(x+1);
    print(compression.shape);
    plt.plot(compression);
    plt.show();


    


#    signal_compression=aproximation_inverse;
#    print("lossy signal reconstruction:");
#    print(signal_compression.shape);
#    plt.plot(signal_compression);
#    plt.show();