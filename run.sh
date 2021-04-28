#!/bin/bash

Xvfb :10 -screen 0 ${RESOLUTION}x24 &> xvfb.log  &
export DISPLAY:=10
cd /root/esmini-self/build/EnvironmentSimulator/Applications/esmini
target=$(echo $SCENARIO | sed 's/\(.*\).xosc/\1\.gif/')
timeout $LENGTH ./esmini --window 0 0 ${RESOLUTION//x/ } --osc "/scenarios/${SCENARIO}" --disable_controllers &
avconv -f x11grab -s $RESOLUTION -r $FRAMERATE -t $LENGTH -y -i :1.0 "/scenarios/${target}"
