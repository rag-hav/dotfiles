#!/bin/bash

gsettings set org.gnome.desktop.notifications show-banners $(if [ "$(gsettings get org.gnome.desktop.notifications show-banners)" = "true" ]; then echo "false"; else echo "true"; fi)
