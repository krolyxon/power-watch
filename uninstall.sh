#!/bin/bash
set -e

echo "Removing power-watch..."

systemctl --user disable --now power-watch.timer || true

rm -f ~/.config/systemd/user/power-watch.service
rm -f ~/.config/systemd/user/power-watch.timer
rm -f ~/.local/bin/power-watch.sh

systemctl --user daemon-reload

echo "Removed."
