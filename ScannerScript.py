from gpiozero import DistanceSensor
from gpiozero import PiGPIOFactory
import pyautogui
import time

factory = PiGPIOFactory()

ultrasonic = DistanceSensor(echo = 17, trigger = 22, threshold_distance = 0.6, max_distance = 1, pin_factory = factory)
while True:
    ultrasonic.wait_for_in_range()
    print("In range")
    print(ultrasonic.distance * 100)
    pyautogui.click(240,400)
    ultrasonic.wait_for_out_of_range()
    print("Out of range")
    print(ultrasonic.distance * 100)

