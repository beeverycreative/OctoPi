BEEwebPI
======

.. image:: https://pbs.twimg.com/profile_images/378800000057657890/e4420ccca1d3d9307434370b6ab1d7d7_200x200.png
.. :scale: 50 %
.. :alt: BEEwebPI logo

A `Raspberry Pi <http://www.raspberrypi.org/>`_ distribution for 3d printers based on the OctoPi project. It includes the `BEEweb <https://github.com/beeverycreative/BEEweb>`_ host software for 3d printers out of the box and `mjpg-streamer with RaspiCam support <https://github.com/jacksonliam/mjpg-streamer>`_ for live viewing of prints and timelapse video creation. This repository contains the source script to generate the distribution out of an existing `Raspbian <http://www.raspbian.org/>`_ distro image.

How to use it?
--------------

#. Unzip the image and install it to an sd card `like any other Raspberry Pi image <https://www.raspberrypi.org/documentation/installation/installing-images/README.md>`_
#. Configure your WiFi by editing ``beewebpi-network.txt`` on the root of the flashed card when using it like a thumb drive
#. Boot the Pi from the card
#. Log into your Pi via SSH (it is located at ``beewebpi.local`` `if your computer supports bonjour <https://learn.adafruit.com/bonjour-zeroconf-networking-for-windows-and-linux/overview>`_ or the IP address assigned by your router), default username is "pi", default password is "raspberry", change the password using the ``passwd`` command and expand the filesystem of the SD card through the corresponding option when running ``sudo raspi-config``.

BEEweb is located at `http://beeweb.local <http://beeweb.local>`_ and also at `https://beeweb.local <https://beeweb.local>`_. Since the SSL certificate is self signed (and generated upon first boot), you will get a certificate warning at the latter location, please ignore it.

If a USB webcam or the Raspberry Pi camera is detected, MJPG-streamer will be started automatically as webcam server. OctoPrint on BEEwebPi ships with correctly configured stream and snapshot URLs pointing at it. If necessary, you can reach it under `http://beeweb.local/webcam/?action=stream <beeweb.local/webcam/?action=stream>`_ and SSL respectively, or directly on its configured port 8080: `http://beeweb.local:8080/?action=stream <beeweb.local:8080/?action=stream>`_.

CuraEngine is installed and BEEweb ships pre-configured with the correct path to utilize it for on-board-slicing. Just import a Cura Slicing Profile in BEEweb's settings and start slicing directly on your Pi.

Features
--------

* `BEEweb <https://github.com/beeverycreative/BEEweb>`_ host software for 3d printers out of the box
* `Raspbian <http://www.raspbian.org/>`_ tweaked for maximum preformance for printing out of the box
* `mjpg-streamer with RaspiCam support <https://github.com/jacksonliam/mjpg-streamer>`_ for live viewing of prints and timelapse video creation.
* `CuraEngine <https://github.com/Ultimaker/CuraEngine>`_ pre-installed for slicing directly on the Raspberry Pi
* Configuration scripts for verious LCD displays


Requirements
~~~~~~~~~~~~

#. `qemu-arm-static <http://packages.debian.org/sid/qemu-user-static>`_
#. Downloaded `Raspbian <http://www.raspbian.org/>`_ image.
#. root privileges for chroot
#. Bash
#. realpath
#. sudo (the script itself calls it, running as root without sudo won't work)

Build BEEwebPi From within BEEwebPi / Raspbian / Debian / Ubuntu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

BEEwebPi can be built from Debian, Ubuntu, Raspbian, or even BEEwebPi.
Build requires about 2.5 GB of free space available.
You can build it by issuing the following commands::

    sudo apt-get install realpath qemu-user-static
    
    git clone https://github.com/guysoft/beewebpi.git
    cd beewebpi/src/image
    curl -J -O -L  http://downloads.raspberrypi.org/raspbian_latest
    cd ..
    sudo modprobe loop
    sudo bash -x ./build
    
Building BEEwebPi Variants
~~~~~~~~~~~~~~~~~~~~~~~~

BEEwebPi supports building variants, which are builds with changes from the main relesae build. An example and other variants are avilable in the folder ``src/variants/example``.

To build a variant use::

    sudo bash -x ./build [Variant]

Usage
~~~~~

#. If needed, override existing config settings by creating a new file ``src/config.local``. You can override all settings found in ``src/config``. If you need to override the path to the Raspbian image to use for building BEEwebPi, override the path to be used in ``ZIP_IMG``. By default the most recent file matching ``*-raspbian.zip`` found in ``src/image`` will be used.
#. Run ``src/build`` as root.
#. The final image will be created at the ``src/workspace``

