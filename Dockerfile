FROM thewtex/opengl:ubuntu2004

WORKDIR /root/

#RUN apt-get -yqq update && apt-get -yq install git pkg-config curl wget xvfb cmake ffmpeg:i386 ffmpeg vim && apt-get autoremove -y && apt-get clean -y && sudo ln -s /usr/bin/ffmpeg /usr/bin/avconv
RUN apt-get -yqq update && apt-get -yq install build-essential git pkg-config libgl1-mesa-dev libpthread-stubs0-dev libjpeg-dev libxml2-dev libtiff5-dev libgdal-dev libpoppler-dev libdcmtk-dev libgstreamer1.0-dev libgtk2.0-dev libcairo2-dev libpoppler-glib-dev libxrandr-dev libxinerama-dev curl wget mkvtoolnix xvfb ffmpeg && apt-get autoremove -y && apt-get clean -y
# libjasper-dev

RUN apt-get -yq install cmake && apt-get autoremove -y && apt-get clean -y && pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip

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
mkdir ~/esmini-self/externals/googletest && \
ln -s /usr/bin/ffmpeg /usr/bin/avconv && \
ln -s /usr/bin/python3 /usr/bin/python


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
#export ESMINI_PATH="/root/esmini-self/build/EnvironmentSimulator/Applications" && \
#export PATH="$PATH:$ESMINI_PATH/esmini:$ESMINI_PATH/odrviewer:$ESMINI_PATH/replayer"

# for open scenario generate
#RUN cd ～/ && \
#pip install scenariogeneration -y && \
#sudo pip3 install Django==3.0.6 -i https://pypi.tuna.tsinghua.edu.cn/simple -y && \
RUN cd ~/ && \
git clone https://github.com/TomcatCbn/openscenario_generator && \
cd openscenario_generator && \
pip install setuptools && \
pip install -r requirements.txt

EXPOSE 8000
ENV DISPLAY :1.0
#ENV LENGTH 20
#ENV RESOLUTION_X 320
#ENV RESOLUTION_Y 240
#ENV FRAMERATE 20
COPY ./run.sh /root/
RUN ["chmod", "+x", "/root/run.sh"]
ENTRYPOINT ["/root/run.sh"]
