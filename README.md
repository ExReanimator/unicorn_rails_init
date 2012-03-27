# Unicorn rails init script

Init script for applications which use unicorn.
It allows to boot unicorn like daemon with system boot and do restart easy.
Also it provide "hot" reload of application.
Based on kiskolabs script.

## Requirements

* Debian-based os
* rvm

## Installation

Move the init.sh to /etc/init.d/YOUR_APP_NAME and correct the settings inside it.

Run the following commands to get it to run on boot:

    $ sudo chmod +x /etc/init.d/YOUR_APP_NAME

    $ sudo update-rc.d YOUR_APP_NAME defaults


## Usage

Examples:

    $ sudo /etc/init.d/YOUR_APP_NAME <start|stop|restart|reload|force-stop>

    # restart will stop and then start unicorn
    # reload will make "hot" reload of unicorn
