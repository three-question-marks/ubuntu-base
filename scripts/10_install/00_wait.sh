#!/bin/sh
set -eu

echo \> Waiting for cloud-init to finish
cloud-init status --wait
