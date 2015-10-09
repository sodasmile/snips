#
# Tags: pi, mpd, hardware, switch, tactile, button, interrupt, debounce
#
# Sets up interrupts to react on button presses to control mpd-deamon
# Expected hardware layout: 
#
# Ground ---- tactile button ---- GPIO pin
# 

import RPi.GPIO as GPIO
import time
import socket
import logging

logging.basicConfig(format="%(asctime)-15s %(message)s")
logging.root.setLevel(logging.INFO)

GPIO.setmode(GPIO.BCM)

NEXT_PIN = 22
PLAY_PIN = 6
PREV_PIN = 5

MPD_HOST = 'localhost'
MPD_PORT = 6600

COMA = {
  NEXT_PIN : 'next',
  PLAY_PIN : 'pause',
  PREV_PIN : 'previous'
}

def my_callback(channel):
  logging.info("Button %s was pressed", COMA[channel])
  client(COMA[channel] + '\n')

for pin in COMA:
  GPIO.setup(pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)    
  GPIO.add_event_detect(pin, GPIO.FALLING, callback=my_callback, bouncetime=100)

def client(message):
   HOST, PORT = MPD_HOST, MPD_PORT
   sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
   sock.connect((HOST, PORT))
   sock.send(bytes(message, 'UTF-8'))
   reply = sock.recv(16384)
   sock.close()
   print(reply.decode('UTF-8'))
   return reply

while True:
    time.sleep(2)
