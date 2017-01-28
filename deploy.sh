#!/usr/bin/env bash
docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PASSWORD
docker push strothj/ansible
