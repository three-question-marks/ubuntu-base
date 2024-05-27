#!/bin/sh
set -eu

echo \> Cleaning up journald logs
journalctl --flush --rotate --vacuum-time=1s
journalctl --user --flush --rotate --vacuum-time=1s
