# Fetch and pull from GitHub to get newest file changes.
cd /home/pi/Scanner
git fetch
git pull

# Run the startup script
bash /home/pi/Scanner/startup.sh > /home/pi/Desktop/startup_log.txt 2>&1

