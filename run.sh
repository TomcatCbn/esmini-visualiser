#!/bin/bash

#Xvfb :1 -screen 0 ${RESOLUTION}x24 &> xvfb.log  &
#cd /root/esmini-self/build/EnvironmentSimulator/Applications/esmini
#target=$(echo $SCENARIO | sed 's/\(.*\).xosc/\1\.gif/')
#timeout $LENGTH ./esmini --window 0 0 ${RESOLUTION//x/ } --osc "/scenarios/${SCENARIO}" --disable_controllers &
#avconv -f x11grab -s $RESOLUTION -r $FRAMERATE -t $LENGTH -y -i :1.0 "/scenarios/${target}"

# ------------------------------------------------
VAR_APP="open_scenario_generator"
function djangorunserver {
    echo "start django project [$VAR_APP]"
    echo "visit by http://127.0.0.1:8000"
    cd /root/openscenario_generator/
    python manage.py runserver 0.0.0.0:8000
    echo -en
}

function update {
    echo "start check if need update"
    cd /root/openscenario_generator/
    git pull
}

update
djangorunserver