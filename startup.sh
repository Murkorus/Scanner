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
nohup chromium-browser \
  --no-sandbox \
  --kiosk \
  --app=https://sorter.noelg.dk/scanner \
  --disable-features=TranslateUI \
  --disable-gpu \
  --disable-extensions \
  --start-maximized \
  > /dev/null 2>&1 & disown

echo "$(date): startup.sh passed starting chromium - Simulating keypresses" >> /home/pi/Desktop/debug.log

# Wait a bit to make sure the website has booted up
sleep 8

# Open popup menu from website
xdotool key k
sleep 1

# Close original website window again so the camera can be used
xdotool mousemove 456 50 click 1
sleep 10

echo "$(date): startup.sh passed mouse click, starting fullscreen function" >> /home/pi/Desktop/debug.log

# Wait for Chromium to finish all its internal mess (adjust time as needed)
sleep 20

# Find the latest visible Chromium window
CAM_WINDOW=$(xdotool search --onlyvisible --class "chromium" | tail -n 1)

# Activate and focus the window
xdotool windowactivate "$CAM_WINDOW"
sleep 1

# Send a single F11 to go fullscreen AFTER everything else
xdotool key --window "$CAM_WINDOW" F11

echo "$(date): startup.sh finished executing - Startup completed, quitting." >> /home/pi/Desktop/debug.log
echo "$(date): test" >> /home/pi/Desktop/debug.log