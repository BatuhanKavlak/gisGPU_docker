ARG CUDA=10.0
ARG CUDNN=7

FROM nvidia/cuda:${CUDA}-cudnn${CUDNN}-runtime-ubuntu18.04
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# install dependencies    
RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends\     
        build-essential \
        software-properties-common \
        python3.6 \
        python3-dev \
        python3-tk \
        python3-pip \
        build-essential \
        libfreetype6-dev \
        libpng-dev \
        libzmq3-dev \
        libspatialindex-dev \
        gdal-bin \
        libgdal-dev \
        python3-gdal \
        libsm6 \
        vim \
        wget \
        zip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*    

# install python package
RUN pip3 --no-cache-dir install setuptools && \
    pip3 --no-cache-dir install wheel && \
    pip3 install \
        jupyterlab \
        numpy \
        scipy \
        Pillow \
        matplotlib \
        opencv-contrib-python \
        scikit-image \
        scikit-learn \
        xgboost \
        fiona \
        shapely \
        geopandas \
        rasterio \
        tifffile

RUN python3 -m pip install --upgrade pip

# install deep learning framework
RUN pip3 --no-cache-dir install \
    https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-2.1.0-cp36-cp36m-manylinux2010_x86_64.whl \
    keras

RUN pip3 --no-cache-dir install --upgrade --force-reinstall tensorflow-gpu

WORKDIR "/edenazar/data"
CMD ["/bin/bash"]
