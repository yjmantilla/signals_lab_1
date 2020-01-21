# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

#libraries
import scipy.io as sio;
import matplotlib.pyplot as plt;
import numpy as np;
import scipy.signal as siosx;
import wfdb.io as wafo;

#loading of the ecg

#for wfdb files
#signals, fields = wafo.rdsamp(record_name, sampfrom=0, sampto='end', channels='all', pb_dir=None)

raw_signal, fields = wafo.rdsamp('aami3a', sampfrom=0, sampto='end', channels='all', pb_dir=None)
print("loaded fields are: " +str(fields));

#for mat files:
#mat_contents=sio.loadmat('path to data')
#print("loaded fields are: " +str(mat_contents.keys()));

#the field of interest is 'ecg'
#for the wfdb signal is already that field

#for mat:
#signal=mat_contents['ecg'];

signal=np.squeeze(raw_signal);

#preliminary visualization of the signal
print("original signal and size");
print(signal.shape);
plt.plot(signal);
plt.show();

#definition of the signals of the transform:

wavelet=[1/np.sqrt(2),-1/np.sqrt(2)];
wavelet=np.asarray(wavelet);
print("wavelet");
print(wavelet.shape);
plt.plot(wavelet);
plt.show();


scale=[1/np.sqrt(2),1/np.sqrt(2)];
scale=np.asarray(scale);
print("scale");
print(scale.shape);
plt.plot(scale);
plt.show();

#aproximation and detail

aproximation=np.correlate(signal,scale,'full');
detail=np.correlate(signal,wavelet,'full');

#check dimensions

print("signal size: " + str(np.size(signal)));
print("aproximation size: "+str(np.size(aproximation)));
print("detail size: "+str(np.size(detail)));

#visualization with no every-other-element previous correction
print("correlation with no every-other-element correction");
print(aproximation.shape);
plt.plot(aproximation);
plt.show();
print(detail.shape);
plt.plot(detail);
plt.show();

#every other element correction
#first elements are neither averages nor differences, so we start at 1 instead of 0

aproximation=aproximation[1::2];
detail=detail[1::2];

print("correlation with every-other-element correction");
print(aproximation.shape);
plt.plot(aproximation);
plt.show();
print(detail.shape);
plt.plot(detail);
plt.show();


#getting the haar transform
haar=np.concatenate((aproximation,detail));
print("haar transform of the signal:");
print(haar.shape);
plt.plot(haar);
plt.show();


#reconstruction of the signal

#getting the inverse 
aproximation_inverse=np.zeros((2*aproximation.shape[0],1));
aproximation_inverse=np.squeeze(aproximation_inverse);
aproximation_inverse[0::2]=aproximation;
aproximation_inverse[1::2]=aproximation;
aproximation_inverse=aproximation_inverse*(1/np.sqrt(2));

print("inverse of the aproximation:");
print(aproximation_inverse.shape);
plt.plot(aproximation_inverse);
plt.show();


detail_inverse=np.zeros((2*detail.shape[0],1));
detail_inverse=np.squeeze(detail_inverse);
detail_inverse[0::2]=detail;
detail_inverse[1::2]=-1*detail;
detail_inverse=detail_inverse*(1/np.sqrt(2));

print("inverse of the detail:");
print(detail_inverse.shape);
plt.plot(detail_inverse);
plt.show();



signal_reconstruction=aproximation_inverse + detail_inverse;

print("lossless signal reconstruction:");
print(signal_reconstruction.shape);
plt.plot(signal_reconstruction);
plt.show();

signal_compression=aproximation_inverse;
print("lossy signal reconstruction:");
print(signal_compression.shape);
plt.plot(signal_compression);
plt.show();

delta=signal_reconstruction-signal_compression
print("difference of reconstruction vs compression:");
print(delta.shape);
plt.plot(delta);
plt.show();
print("obviously this is equal to the detail...")
