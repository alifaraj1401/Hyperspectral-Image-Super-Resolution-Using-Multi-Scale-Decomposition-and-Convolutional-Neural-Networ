from keras.models import Sequential
from keras.models import Model
from keras.layers import Input, Convolution3D

import  keras
import h5py
from keras.optimizers import Adam

def srcnn(input_shape=(33,33,110,1)):

    model = Sequential()
    model.add(Convolution3D(64, 7, 7, 3, input_shape=input_shape, activation='relu'))
    model.add(Convolution3D(32, 3, 3, 3, activation='relu'))
    model.add(Convolution3D(9, 3, 3, 3, activation='relu'))
    model.add(Convolution3D(1, 3, 3, 3))
    model.compile(Adam(lr=0.00005), 'mse')
    return model




