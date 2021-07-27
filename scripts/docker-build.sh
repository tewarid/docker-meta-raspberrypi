#!/bin/sh
docker build -t berry:latest --build-arg KAS_TARGET="$KAS_TARGET" .
