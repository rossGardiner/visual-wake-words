FROM tensorflow/tensorflow:1.15.2-gpu-py3-jupyter

RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list
LABEL maintainer="Luke Berndt <lberndt@iqt.org>"

RUN apt-get update && apt-get install -y \
    git \
    xxd

RUN git clone https://github.com/rossGardiner/models.git

RUN pip3 install --upgrade pip

RUN pip install contextlib2 Pillow tf_slim tensorflowjs

ENV PYTHONPATH "${PYTHONPATH}:/tf/models/research/slim"
