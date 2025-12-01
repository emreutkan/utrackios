#!/bin/bash

XCODE_PATH="/Users/emre/Downloads/Xcode.app"
XCODEBUILD="$XCODE_PATH/Contents/Developer/usr/bin/xcodebuild"
SIMULATOR_NAME="iPhone 17 Pro"

# Build the app
echo "Building app..."
$XCODEBUILD -project utrack.xcodeproj \
  -scheme utrack \
  -destination "platform=iOS Simulator,name=$SIMULATOR_NAME" \
  -derivedDataPath ./build \
  build

if [ $? -eq 0 ]; then
  echo "Build succeeded! Opening in Xcode to run..."
  open utrack.xcodeproj
  echo "In Xcode: Select '$SIMULATOR_NAME' from device menu and press Cmd+R"
else
  echo "Build failed"
  exit 1
fi

