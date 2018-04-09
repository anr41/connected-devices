#!/bin/bash

cd ~/connected-devices/Lampi/pkg/

sudo cp -R ../bluetooth/ lampi/opt/lampi/
sudo cp -R ../Hardware/ lampi/opt/lampi/
sudo cp -R ../images/ lampi/opt/lampi/
sudo cp ../lamp_cmd lampi/opt/lampi/
sudo cp ../lamp_common.py lampi/opt/lampi/
sudo cp -R ../lampi/ lampi/opt/lampi/
sudo cp ../lamp_service.py lampi/opt/lampi/
sudo cp ../main.py lampi/opt/lampi/lamp_ui.py
sudo cp -R ../scripts lampi/opt/lampi/

sudo mv lampi/opt/lampi/bluetooth/peripheral.js lampi/opt/lampi/bt_peripheral.js 
bumpversion minor --allow-dirty
dpkg-deb --build lampi
reprepro -b ~/connected-devices/Web/reprepro/ubuntu/ includedeb ashley lampi.deb
