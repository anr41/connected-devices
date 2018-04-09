#!/bin/bash

cd ~/connected-devices/Lampi/pkg/

cp -r ../bluetooth/ lampi/opt/lampi/
cp -r ../Hardware/ lampi/opt/lampi/
cp -r ../images/ lampi/opt/lampi/
cp ../lamp_cmd lampi/opt/lampi/
cp ../lamp_common.py lampi/opt/lampi/
cp -r ../lampi/ lampi/opt/lampi/
cp ../lamp_service.py lampi/opt/lampi/
cp ../main.py lampi/opt/lampi/lamp_ui.py
cp -r ../scripts lampi/opt/lampi/

mv lampi/opt/lampi/bluetooth/peripheral.js lampi/opt/lampi/bt_peripheral.js 

bumpversion minor --allow-dirty
dpkg-deb --build lampi
reprepro -b ~/connected-devices/Web/reprepro/ubuntu/ includedeb ashley lampi.deb
