#!/usr/bin/bash

find \( -name 'core.*' -o -name 'zig-out' -o -name '.zig-cache' \) -exec rm -rf {} +
