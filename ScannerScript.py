from gpiozero import DistanceSensor
import pyautogui
import time
ultrasonic = DistanceSensor(echo = 22, trigger = 17, threshold_distance = 0.6, max_distance = 1)
while True:
    ultrasonic.wait_for_in_range()
    print("In range")
    print(ultrasonic.distance * 100)
    pyautogui.click(240,400)
    ultrasonic.wait_for_out_of_range()
    print("Out of range")
    print(ultrasonic.distance * 100)

