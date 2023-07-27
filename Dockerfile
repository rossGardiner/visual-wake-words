FROM tensorflow/tensorflow:1.15.2-gpu-py3-jupyter

WORKDIR /tf
COPY train_models.sh /tf/
RUN ["chmod", "+x", "/tf/train_models.sh"]
COPY config.cfg /tf/

RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update && apt-get install -y \
    git \
    xxd
    
RUN apt-get install ffmpeg libsm6 libxext6  -y

RUN git clone https://github.com/rossGardiner/models.git

RUN pip3 install --upgrade pip

RUN pip3 install contextlib2 Pillow tf_slim opencv-python

ENV PYTHONPATH "${PYTHONPATH}:/tf/models/research/slim"

CMD ["/tf/train_models.sh"]