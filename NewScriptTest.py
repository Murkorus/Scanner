from gpiozero import DistanceSensor
from time import sleep
import pyautogui

sensor = DistanceSensor(echo=24, trigger=22, threshold_distance = 0.6, max_distance = 1)

try:
    while True:
        try:
            distance_cm = sensor.distance * 100  # distance is in meters
            print(f"Distance: {distance_cm:.1f} cm")
        except OSError:
            # Catch and skip "No echo received" errors
            print("Warning: No echo received.")
        sleep(0.1)  # adjust as needed, no faster than 60ms recommended
except KeyboardInterrupt:
    print("Exiting.")