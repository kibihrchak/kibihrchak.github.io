---
layout: post
title:  "Heltec ESP32 Door Lock Notifier"
date:   2019-08-11 12:55 +0200
categories: embedded heltec esp32 ifttt
---

# Overview

Last week I've recalled that some month ago I've bought 2 [Heltec's
ESP32 modules][heltec-wifi-lora-32], and after checking them out if they
work put them in a drawer where they stayed ever since. So, thought it
would be good to dust them off and give them a try, especially that I
haven't worked with [Espressif microcontrollers][esp-comparison-table]
before.

After some initial research on the MCU/module, an idea came to me to
make as a mini learning project a door lock notifier. Ever once in a
while I have that "did I leave the oven on?" moment with the apartment
door, so there would be a good place to try out the new module.

# ESP32 and Heltec WiFi LoRa 32 [TODO]

![Heltec WiFi LoRa 32](/assets/images/posts/2019-08-11-heltec-esp32-door-lock-notifier/heltec-wifi-lora-32.jpg)

# Door Lock Notifier [TODO]

## System Components [TODO]

![connection diagram](/assets/images/posts/2019-08-11-heltec-esp32-door-lock-notifier/connection-diagram.png)

### Notification Mechanism [TODO]

### Notifier [TODO]

*   Pinout

![hw-setup](/assets/images/posts/2019-08-11-heltec-esp32-door-lock-notifier/hw-setup.jpg)

[repo][sketch-repo]

## Results [TODO]

<iframe width="560" height="315"
src="https://www.youtube.com/embed/mfEv6WS8OTA" frameborder="0"
allow="accelerometer; autoplay; encrypted-media; gyroscope;
picture-in-picture" allowfullscreen></iframe>

# Resources

*   [heltec-wifi-lora-32] : Module info webpage.
*   [module-resources] : Module schematic, pinout.
*   [esp32-arduino-install] : Arduino setup for ESP32 boards.
*   [heltec-esp32-arduino-lib] : Installation procedure for Heltec ESP32
    Arduino library.
*   [esp-comparison-table] : ESP8266/ESP32 comparison table.

[sketch-repo]: <https://github.com/kibihrchak/door-lock-notifier>

[heltec-wifi-lora-32]: <https://heltec.org/project/wifi-lora-32/>
[module-resources]: <https://github.com/Heltec-Aaron-Lee/WiFi_Kit_series>
[esp32-arduino-install]: <https://github.com/espressif/arduino-esp32/blob/master/docs/arduino-ide/boards_manager.md>
[heltec-esp32-arduino-lib]: <https://github.com/HelTecAutomation/Heltec_ESP32>
[esp-comparison-table]: <https://www.cnx-software.com/2016/03/25/esp8266-and-esp32-differences-in-one-single-table/>

