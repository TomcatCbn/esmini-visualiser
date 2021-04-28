#!/bin/bash

#sudo docker run -v ~/asam/esmini/:/scenarios -e SCENARIO=resources/xosc/cut-in.xosc -e LENGTH=10 -ti openx:v1 /bin/bash



Xvfb -ac :12 -screen 0 400x300x24 &> fir.log & timeout 10 ./bin/esmini --osc resources/xosc/cut-in.xosc --window 0 0 400 300 & avconv -f x11grab -s 400x300 -r 10 -t 10 -y -i :12.0 "output.gif"