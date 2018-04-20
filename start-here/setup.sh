#!/usr/bin/env bash
set -e

STACK_NAME=source-ztsh-stack

aws cloudformation deploy \
    --template-file starting.cf.yml \
    --stack-name ${STACK_NAME}