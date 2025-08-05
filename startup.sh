echo "$(date): Started startup.sh - Starting python script" >> /home/pi/xprofile_debug.log

# Firstly, connect to wifi. This should be handled automatically by the Pi if wifi has been configured correctly previously.

# Start python script, first need to activate virtual environment
source /home/pi/PyVenv/bin/activate
python /home/pi/Scanner/backgroundScript.py &

echo "$(date): startup.sh passed starting python script - pinging google.com" >> /home/pi/xprofile_debug.log

# Wait a bit to make sure everything has started
until ping -c1 google.com &>/dev/null; do sleep 1; done
sleep 5

echo "$(date): startup.sh passed pinging google.com - Launching chromium" >> /home/pi/xprofile_debug.log

# Launch the website
chromium-browser \
  --no-sandbox \
  --disable-gpu \
  --disable-software-rasterizer \
  --disable-extensions \
  --disable-sync \
  --start-fullscreen \
  --app=https://sorter.noelg.dk/scanner &

echo "$(date): startup.sh passed starting chromium - Simulating keypresses" >> /home/pi/xprofile_debug.log

# Wait a bit to make sure the website has booted up
sleep 8

# Open popup menu from website
xdotool key k
sleep 3

# Close original website window again so the camera can be used
xdotool mousemove 456 50 click 1
sleep 2

# Make the popup window fullscreen
xdotool key F11

echo "$(date): startup.sh finished executing - Startup completed, quitting." >> /home/pi/xprofile_debug.log