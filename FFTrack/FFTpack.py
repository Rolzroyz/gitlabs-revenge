import numpy as np #import stuff you dolt
def fft_matrix(x):
    """Takes the Fourier Transform of a array x
    and returns the descrete transform in K space
    Protip: Secretly not a Fast Fourier transform 
    """
    N = x.shape[0]                  # length of transform
    n = np.arange(N,dtype='float')  # initial array of length x
    k = n.reshape((N,1))            # transposed array of length x
    M = np.exp(-2j * np.pi * n * k / N) #transform matrix <3
    return np.dot(x,M) #dot prodtuct/soltion

def ifft_matrix(X_k):
    """Takes the Inverse Fourier Transform of a array X_k
    and returns the descrete transform in K space
    Protip: Secretly not a Fast Fourier transform 
    """
    NN = X_k.shape[0]                  # length of transform
    nn = np.arange(NN,dtype='float')  # initial array of length x
    kk = np.reshape(nn,(NN,1))            # transposed array of length x
    MM = np.exp(-2j * np.pi * nn * kk / NN) #transform matrix <3
    return np.dot(X_k,MM)/NN #dot prodtuct/soltion