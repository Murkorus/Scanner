echo "$(date): Started startup.sh - Starting python script" >> /home/pi/Desktop/debug.log

# Firstly, connect to wifi. This should be handled automatically by the Pi if wifi has been configured correctly previously.

# Start python script, first need to activate virtual environment
source /home/pi/PyVenv/bin/activate
python /home/pi/Scanner/backgroundScript.py &

echo "$(date): startup.sh passed starting python script - pinging google.com" >> /home/pi/Desktop/debug.log

# Wait a bit to make sure everything has started
until ping -c1 google.com &>/dev/null; do sleep 1; done
sleep 5

echo "$(date): startup.sh passed pinging google.com - Launching chromium" >> /home/pi/Desktop/debug.log

# Launch the website
chromium-browser \
  --disable-gpu \
  --disable-software-rasterizer \
  --disable-extensions \
  --disable-sync \
  --start \
  --app=https://sorter.noelg.dk/scanner &

echo "$(date): startup.sh passed starting chromium - Simulating keypresses" >> /home/pi/Desktop/debug.log

# Wait a bit to make sure the website has booted up
sleep 8

# Open popup menu from website
xdotool key k
sleep 1

# Close original website window again so the camera can be used
xdotool mousemove 456 50 click 1
sleep 10

echo "$(date): startup.sh passed mouse click, starting F11 keypresses" >> /home/pi/Desktop/debug.log

# Wait for the pop-out camera window to appear
sleep 2

# Search for the new Chromium window
CAM_WINDOW=$(xdotool search --onlyvisible --class "chromium" | tail -n 1)

# Focus that window
xdotool windowactivate "$CAM_WINDOW"
sleep 1

# Send F11 to fullscreen it
xdotool key --window "$CAM_WINDOW" F11
sleep 15
xdotool key --window "$CAM_WINDOW" F11
sleep 5
xdotool key --window "$CAM_WINDOW" F11
echo "$(date): startup.sh finished executing - Startup completed, quitting." >> /home/pi/Desktop/debug.log