
#!/usr/bin/env bash

set -e

rm -rf dist/
mkdir -p dist

echo 'Building for web ...'
godot --no-window --export "HTML5" dist/web/index.html
echo 'done.'

echo 'Building for linux ...'
godot --no-window --export 'Linux/X11' dist/linux/rootedJourney.x86_64
chmod a+x dist/rootedJourney.x86_64
echo 'done.'

echo 'Building for Windows ...'
godot --no-window --export 'Windows Desktop' dist/windows/rootedJourney.exe
echo 'done.'
