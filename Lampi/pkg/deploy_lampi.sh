#!/bin/bash

cd ~/connected-devices/Lampi/pkg/

cp -a ../bluetooth/ ./lampi/opt/lampi
cp -a ../images/ ./lampi/opt/lampi
cp ../lamp_cmd ./lampi/opt/lampi
cp ../lamp_common.py ./lampi/opt/lampi
cp -a ../lampi/ ./lampi/opt/lampi/lampi
cp ../lamp_service.py ./lampi/opt/lampi
cp ../main.py ./lampi/opt/lampi/lamp_ui.py
mv ./lampi/opt/lampi/bluetooth/peripheral.js ./lampi/opt/lampi/bluetooth/bt_peripheral.js

bumpversion minor
dpkg-deb --build lampi
reprepro -b ~/connected-devices/Web/reprepro/ubuntu/ includedeb lampi lampi.deb
