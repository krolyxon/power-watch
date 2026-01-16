#!/bin/bash
set -e

echo "Installing power-watch..."

mkdir -p ~/.local/bin
mkdir -p ~/.config/systemd/user

cp power-watch.sh ~/.local/bin/power-watch.sh
chmod +x ~/.local/bin/power-watch.sh

cp systemd/power-watch.service ~/.config/systemd/user/
cp systemd/power-watch.timer ~/.config/systemd/user/

systemctl --user daemon-reload
systemctl --user enable --now power-watch.timer

echo "Enabling lingering..."
sudo loginctl enable-linger "$USER"

echo "Done! Power Watch is running."
echo "Test with: systemctl --user start power-watch.service"

