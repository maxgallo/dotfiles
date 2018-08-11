#!/bin/bash

echo ">> Installing packages"
pip3 install numpy
pip3 install scipy pillow
pip3 install imutils h5py requests progressbar2
pip3 install scikit-learn scikit-image
pip3 install matplotlib
touch ~/.matplotlib/matplotlibrc
echo "backend: TkAgg" >> ~/.matplotlib/matplotlibrc
pip3 install tensorflow==1.4
pip3 install keras
pip3 install pandas
pip3 install quandl
pip3 install pymongo

