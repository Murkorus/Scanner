# Firstly, connect to wifi. This should be handled automatically by the Pi if wifi has been configured correctly previously.

# Fetch and pull from GitHub to get newest file changes.
cd /home/pi/Scanner
git fetch
git pull

# Start python script, first need to activate virtual environment
source /home/pi/PyVenv/bin/activate
python /home/pi/Scanner/backgroundScript.py &

# Wait a bit to make sure everything has started
sleep 5

# Launch the website
chromium-browser --no-sandbox --start --app=https://sorter.noelg.dk/scanner &

# Wait a bit to make sure the website has booted up
sleep 8

# Open popup menu from website
xdotool key k
sleep 3

# Close original website window again so the camera can be used
xdotool mousemove 479 54 click 1
sleep 2

# Make the popup window fullscreen
xdotool key F11