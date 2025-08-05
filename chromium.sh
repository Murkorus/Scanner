#!/bin/bash
sleep 10  # give time for everything else to settle

chromium-browser \
  --app=https://sorter.noelg.dk/scanner \
  --disable-gpu \
  --disable-extensions \
  --start-maximized \
  > /dev/null 2>&1 &
disown