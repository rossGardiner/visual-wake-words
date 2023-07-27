FROM nvcr.io/nvidia/tensorflow:20.06-tf1-py3

WORKDIR /tf
COPY train_models.sh /tf/
RUN ["chmod", "+x", "/tf/train_models.sh"]
COPY config.cfg /tf/

#RUN rm /etc/apt/sources.list.d/cuda.list
#RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update && apt-get install -y \
    git \
    xxd 
    #jupyter-notebook
    
RUN apt-get install ffmpeg libsm6 libxext6  -y

RUN git clone https://github.com/rossGardiner/models.git

RUN pip3 install --upgrade pip

RUN pip3 install contextlib2 Pillow tf_slim opencv-python==4.5.3.56

ENV PYTHONPATH "${PYTHONPATH}:/tf/models/research/slim"

CMD ["/tf/train_models.sh"]
