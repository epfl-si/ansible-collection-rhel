#!/usr/bin/env bash

buildah bud --format=oci -t ubi8-init-molecule:1.0.0 -f Dockerfile_el8
buildah bud --format=oci -t ubi7-init-molecule:1.0.0 -f Dockerfile_el7
