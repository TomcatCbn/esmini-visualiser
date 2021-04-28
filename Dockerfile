FROM ubuntu:xenial

WORKDIR /root/

RUN apt-get -yqq update && apt-get -yq install git pkg-config curl wget xvfb cmake ffmpeg:i386 ffmpeg vim && apt-get autoremove -y && apt-get clean -y && sudo ln -s /usr/bin/ffmpeg /usr/bin/avconv

# RUN version=3.15 && \
# build=3 && \
# mkdir ~/temp && \
# cd ~/temp && \
# wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz && \
# tar -xzvf cmake-$version.$build.tar.gz && \
# cd cmake-$version.$build/ && \
# ./bootstrap && \
# make -j4 && \
# make install

# RUN cd ~/ && \
# git clone https://github.com/openscenegraph/OpenSceneGraph && \
# cd OpenSceneGraph && \
# git checkout OpenSceneGraph-3.6.3 && \
# mkdir build && \
# cd build && \
# cmake ../ && \
# make -j4 && \
# make install && \
# ldconfig

RUN cd ~/ && \
git clone https://github.com/TomcatCbn/esmini-self && \
cd esmini-self && \
mkdir ~/esmini-self/externals/OSI && \
mkdir ~/esmini-self/externals/OpenSceneGraph && \
mkdir ~/esmini-self/externals/SUMO && \
mkdir ~/esmini-self/externals/googletest

COPY ./osi.7z /root/esmini-self/externals/OSI/
COPY ./sumo.7z /root/esmini-self/externals/SUMO/
COPY ./googletest.7z /root/esmini-self/externals/googletest/
COPY ./models.7z /root/esmini-self/resources/
COPY ./osg.7z /root/esmini-self/externals/OpenSceneGraph/

RUN cd ~/esmini-self && \
mkdir build && \
cd build && \
cmake .. && \
make -j4

# for open scenario generate
#RUN cd ～/ && \
#pip install scenariogeneration -y && \
#sudo pip3 install Django==3.0.6 -i https://pypi.tuna.tsinghua.edu.cn/simple -y && \


ENV DISPLAY :1.0
ENV LENGTH 20
ENV RESOLUTION 320x240
ENV FRAMERATE 20
COPY ./run.sh ~/
RUN ["chmod", "+x", "~/run.sh"]
#ENTRYPOINT ["~/run.sh"]
