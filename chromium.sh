# Launch the website
nohup chromium-browser \
  --no-sandbox \
  --kiosk \
  --app=https://sorter.noelg.dk/scanner \
  --disable-features=TranslateUI \
  --disable-gpu \
  --disable-extensions \
  --start-maximized \
  > /dev/null 2>&1 & disown