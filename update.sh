echo "$(date): Started update.sh - Pulling from GitHub" >> /home/pi/xprofile_debug.log
# Fetch and pull from GitHub to get newest file changes.
cd /home/pi/Scanner
git fetch
git pull

echo "$(date): update.sh passed GitHub pull, starting startup.sh" >> /home/pi/xprofile_debug.log
# Run the startup script
bash /home/pi/Scanner/startup.sh > /home/pi/Desktop/startup_log.txt 2>&1

