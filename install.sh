#!/bin/bash

# Name of the folder that will be created in the system
THEME_NAME="frieren-animated"
THEME_DIR="/usr/share/sddm/themes/$THEME_NAME"
CONF_DIR="/etc/sddm.conf.d"
CONF_FILE="$CONF_DIR/10-theme.conf"

# 1. Check if the script is run as root (sudo)
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root."
  echo "Usage: sudo ./install.sh"
  exit 1
fi

echo "Starting the installation of the Frieren SDDM theme..."

# 2. Create the theme directory and copy the files
echo "Copying files to $THEME_DIR..."
mkdir -p "$THEME_DIR"
cp -r ./* "$THEME_DIR/"

# 3. Adjust permissions (critical for SDDM to read the font and video)
echo "Adjusting permissions..."
chmod -R 755 "$THEME_DIR"
# Make the installation script non-executable in the destination directory
chmod 644 "$THEME_DIR/install.sh" 

# 4. Apply the theme by configuring SDDM
echo "Configuring SDDM to use the new theme..."
mkdir -p "$CONF_DIR"

# Overwrite or create the configuration file to force the theme
cat <<EOF > "$CONF_FILE"
[Theme]
Current=$THEME_NAME
EOF

echo "Installation completed successfully!"
echo "To see the changes, log out or restart your computer."
