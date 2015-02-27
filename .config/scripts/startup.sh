#!/bin/sh
# Need this because Apache is running on boot, methinks.
sudo apachectl graceful
