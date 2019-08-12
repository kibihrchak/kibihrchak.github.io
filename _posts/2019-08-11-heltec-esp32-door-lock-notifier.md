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
haven't worked with Espressif microcontrollers before.

After some initial research on the MCU/module, an idea came to me to
make as a mini learning project a door lock notifier. Ever once in a
while I have that "did I leave the oven on?" moment with the apartment
door, so there would be a good place to try out the new module.

# ESP32 and Heltec WiFi LoRa 32 [TODO]

![Heltec WiFi LoRa 32](/assets/images/posts/2019-08-11-heltec-esp32-door-lock-notifier/heltec-wifi-lora-32.jpg)

# Door Lock Notifier [TODO]

As for the mini project, the concept is following:

1.  Let the module somehow detect that the door has locked/unlocked.
2.  Upon detecting the change, connect to local WiFi AP, then to the
    IFTTT server, and send a POST request containing the update message.
3.  IFTTT will then using its Telegram bot generate a new message in the
    messenger.
4.  This message can then be observed via phone.

Here's a schematic overview of the system components -

![connection diagram](/assets/images/posts/2019-08-11-heltec-esp32-door-lock-notifier/connection-diagram.png)

## Particular Issues [TODO]

A couple of issues were tackled during the prototyping.

### Detect Door Lock/Unlock [TODO]

### Increase The Module Autonomy

As the module is running on a battery, it would be preferrable to lower
its power consumption so that it can operate for the extended period of
time. Of course, connecting it on an USB adapter would be the best
solution, but there were none close to the door and stretching the
cables over the wall wasn't an option.

Fortunately, ESP32 supports several power models, one of them being a
deep-sleep one, with -

*   ~6.5uA current consumption
*   RTC memory persistence
*   External wake-up source
*   And most importantly for fast prototyping, Arduino example sketch

So, the solution was to use the door lock detection switch as a wake-up
source, and set the wake-up level opposite of the last read out.

## System Components [TODO]

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

## Other Notes [TODO]

*   Module quality

# Resources

*   [heltec-wifi-lora-32] : Module info webpage.
*   [module-resources] : Module schematic, pinout.
*   [esp32-arduino-install] : Arduino setup for ESP32 boards.
*   [heltec-esp32-arduino-lib] : Installation procedure for Heltec ESP32
    Arduino library.
*   [esp-comparison-table] : ESP8266/ESP32 comparison table.
*   [esp32-trm] : ESP32 technical reference manual.

[sketch-repo]: <https://github.com/kibihrchak/door-lock-notifier>

[heltec-wifi-lora-32]: <https://heltec.org/project/wifi-lora-32/>
[module-resources]: <https://github.com/Heltec-Aaron-Lee/WiFi_Kit_series>
[esp32-arduino-install]: <https://github.com/espressif/arduino-esp32/blob/master/docs/arduino-ide/boards_manager.md>
[heltec-esp32-arduino-lib]: <https://github.com/HelTecAutomation/Heltec_ESP32>
[esp-comparison-table]: <https://www.cnx-software.com/2016/03/25/esp8266-and-esp32-differences-in-one-single-table/>
[esp32-trm]: <https://www.espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf>
