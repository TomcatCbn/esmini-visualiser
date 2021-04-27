FROM thewtex/opengl:ubuntu1604

WORKDIR ~/

RUN apt-get -yqq update && apt-get -yq install build-essential git pkg-config libgl1-mesa-dev libpthread-stubs0-dev libjpeg-dev libxml2-dev libpng12-dev libtiff5-dev libgdal-dev libpoppler-dev libdcmtk-dev libjasper-dev libgstreamer1.0-dev libgtk2.0-dev libcairo2-dev libpoppler-glib-dev libxrandr-dev libxinerama-dev curl wget libav-tools mkvtoolnix xvfb && apt-get autoremove -y && apt-get clean -y

RUN version=3.15 && \
build=3 && \
mkdir ~/temp && \
cd ~/temp && \
wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz && \
tar -xzvf cmake-$version.$build.tar.gz && \
cd cmake-$version.$build/ && \
./bootstrap && \
make -j4 && \
make install

RUN cd ~/ && \
git clone https://github.com/openscenegraph/OpenSceneGraph && \
cd OpenSceneGraph && \
git checkout OpenSceneGraph-3.6.3 && \
mkdir build && \
cd build && \
cmake ../ && \
make -j4 && \
make install && \
ldconfig

RUN cd ~/ && \
git clone https://github.com/TomcatCbn/esmini-self && \
cd esmini-self && \
#mkdir -p externals/OpenSceneGraph/v10/build && \
#OSG_PATH=~/OpenSceneGraph && \
#cp -a $OSG_PATH/build/lib externals/OpenSceneGraph/linux/ && \
#cp -a $OSG_PATH/build/include externals/OpenSceneGraph/linux/build && \
#cp -a $OSG_PATH/include externals/OpenSceneGraph/linux/ && \
mkdir ~/esmini-self/externals/OSI && \
mkdir ~/esmini-self/externals/SUMO && \
mkdir ~/esmini-self/externals/googletest

COPY ./osi.7z /root/esmini-self/externals/OSI/
COPY ./sumo.7z /root/esmini-self/externals/SUMO/
COPY ./googletest.7z /root/esmini-self/externals/googletest/
COPY ./models.7z /root/resources/
COPY ./OSG.7z /root/esmini-self/externals/OpenSceneGraph/

RUN cd ~/esmini-self && \
#cd externals/OSI && \
#tar -zxf osi_linux.7z && \
#cd ../SUMO && \
#tar -zxf sumo_linux.7z && \
#cd ../googletest && \
#tar -zxf googletest_linux.7z && \
#cd ~/esmini-self && \
mkdir build && \
cd build && \
cmake ../ -DUSE_OSG=true && \
make -j4

ENV DISPLAY :1.0
ENV LENGTH 20
ENV RESOLUTION 320x240
ENV FRAMERATE 20
COPY ./run.sh ~/
RUN ["chmod", "+x", "~/run.sh"]
ENTRYPOINT ["~/run.sh"]
