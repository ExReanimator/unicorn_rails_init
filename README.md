# Unicorn rails init script

Init script for applications which using unicorn.
It allows to boot unicorn like daemon with system boot and do restart easy.
Based on kiskolabs script.

## Requirements

* Debian-based os

## Installation

Move the script to /etc/init.d/YOUR_APP_NAME and correct the settings inside it.

Run the following commands to get it to run on boot:

    $ sudo chmod +x /etc/init.d/YOUR_APP_NAME

    $ sudo update-rc.d YOUR_APP_NAME defaults


## Usage

Examples:

    $ sudo /etc/init.d/YOUR_APP_NAME <start|stop|restart|upgrade|rotate|force-stop>
