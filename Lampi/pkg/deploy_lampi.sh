#!/bin/bash

cd ~/connected-devices/Lampi/pkg/
bumpversion minor
dpkg-deb --build lampi
reprepro -b ~/connected-devices/Web/reprepro/ubuntu/ includedeb lampi lampi.deb
