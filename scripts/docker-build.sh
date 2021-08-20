#!/bin/sh
docker build -t amora:latest --build-arg KAS_TARGET="$KAS_TARGET" .
