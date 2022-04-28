import os
import h5py
import net3D
import argparse
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
from keras.models import Sequential, load_model
from keras.callbacks import ModelCheckpoint

#os.environ['CUDA_VISIBLE_DEVICES']='0'
def train():
    model = net3D.srcnn()
    model.summary()


    h5f = h5py.File(args.input_data, 'r')
    X = h5f['data']
    y = h5f['label'].value[:,:,:,4:-4,:]

    n_epoch = args.n_epoch
    filepath = 'D:/test/arch3to3scale2\pavia\ctapp\deffcoarse\save/checkpointapp-{epoch:02d}-{loss:.2f}.h5'
    checkpoint = ModelCheckpoint(filepath, monitor='loss', verbose=1, save_best_only=False, save_weights_only=False,
                                 mode='min')
    callbacks_list = [checkpoint]
    if not os.path.exists(args.save):
        os.mkdir(args.save)

    for epoch in range(0, n_epoch,n_epoch):
        H = model.fit(X, y, batch_size=16, nb_epoch=n_epoch, shuffle='batch',callbacks=callbacks_list)
        if args.save:
            print("Saving model ", epoch + n_epoch)
            model.save(os.path.join(args.save, 'app_%d.h5' %(epoch+n_epoch)))

            # plot the training loss
            plt.style.use("ggplot")
            plt.figure()
            plt.plot(np.arange(0, epoch+n_epoch), H.history["loss"],label="loss")
            plt.title("Loss on super resolution training")
            plt.xlabel("Epoch #")
            plt.ylabel("Loss")
            plt.legend()
            plt.savefig(os.path.sep.join(['./figure', "plot.png"]))

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-S', '--save',
                        default='./save',
                        dest='save',
                        type=str,
                        nargs=1,
                        help="Path to save the checkpoints to")
    parser.add_argument('-D', '--data',
                        default='data_process/pa_train_3d_all_datadetct.h5',
                        dest='input_data',
                        type=str,
                        nargs=1,
                        help="Training data directory")
    parser.add_argument('-E', '--epoch',
                        default=100,
                        dest='n_epoch',
                        type=int,
                        nargs=1,
                        help="Training epochs must be a multiple of 5")
    args = parser.parse_args()
    print(args)
    train()
