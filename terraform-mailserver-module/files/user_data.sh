#!/bin/#!/usr/bin/env bash

# postfix is installed by default - remove it so that port 25 is freed up
yum remove postfix

# create mail directory and allow the vmail user (uid 500) to write to it
mkdir -p /ecs/maildata && chown 500:500 /ecs/maildata
