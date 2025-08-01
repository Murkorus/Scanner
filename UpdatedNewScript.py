from gpiozero import DistanceSensor
from time import sleep

sensor = DistanceSensor(echo=24, trigger=22, threshold_distance = 0.6, max_distance = 1)
THRESHOLD_CM = 60.0

print("Starting sensor loop...")

try:
    while True:
        # Step 1: Wait for object within range
        while True:
            try:
                distance_cm = sensor.distance * 100
                if distance_cm < THRESHOLD_CM:
                    print(f"Object is: {distance_cm:.1f} cm away")
                    break
            except OSError:
                print("No echo recieved, trying again...")
            sleep(0.1)

        # Step 2: Wait for object to leave range
        while True:
            try:
                distance_cm = sensor.distance * 100
                if distance_cm >= THRESHOLD_CM:
                    print("Object removed – waiting for the next object...")
                    break
            except OSError:
                print("No echo recieved, trying again...")
            sleep(0.1)

except KeyboardInterrupt:
    print("Quitting...")