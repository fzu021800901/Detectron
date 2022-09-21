# Use Caffe2 image as parent image
FROM caffe2/caffe2:snapshot-py2-cuda9.0-cudnn7-ubuntu16.04

RUN pip install --upgrade pip
RUN mv /usr/local/caffe2 /usr/local/caffe2_build
ENV Caffe2_DIR /usr/local/caffe2_build

ENV PYTHONPATH /usr/local/caffe2_build:${PYTHONPATH}
ENV LD_LIBRARY_PATH /usr/local/caffe2_build/lib:${LD_LIBRARY_PATH}

# Clone the Detectron repository
#RUN git clone https://github.com/facebookresearch/detectron /detectron

# Install Python dependencies
#RUN pip install -r /detectron/requirements.txt

RUN pip install numpy>=1.13 pyyaml==3.12 matplotlib opencv-python==4.1.1.26 setuptools Cython mock scipy six future protobuf

# Install the COCO API
RUN git clone https://github.com/cocodataset/cocoapi.git /cocoapi
WORKDIR /cocoapi/PythonAPI
RUN make install

# Go to Detectron root
WORKDIR /detectron

# Set up Python modules
RUN make

# [Optional] Build custom ops
RUN make ops
