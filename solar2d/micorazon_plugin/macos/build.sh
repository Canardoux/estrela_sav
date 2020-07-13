#!/bin/bash

TARGET_NAME=micorazon
CONFIG=Debug
DEFAULT_OUTPUT=~/Sites/download

#--------------------------------------------------

path=$(dirname "$0")
OUTPUT_DIR=$1
OUTPUT_SUFFIX=dylib

#
# Checks exit value for error
#
checkError() {
    if [ $? -ne 0 ]
    then
        echo "Exiting due to errors (above)"
        exit -1
    fi
}

#
# Canonicalize relative paths to absolute paths
#
pushd $path > /dev/null
dir=`pwd`
path=$dir
popd > /dev/null

if [ -z "$OUTPUT_DIR" ]
then
    OUTPUT_DIR="$DEFAULT_OUTPUT"
fi

pushd $OUTPUT_DIR > /dev/null
dir=`pwd`
OUTPUT_DIR=$dir
popd > /dev/null

mkdir -p $OUTPUT_DIR/macos 2>/dev/null
mkdir -p ../../output/macos 2>/dev/null


xcodebuild -project "$path/Plugin.xcodeproj" -configuration $CONFIG clean
checkError

xcodebuild -project "$path/Plugin.xcodeproj" -configuration $CONFIG
checkError

cp -v "$path/build/$CONFIG/$TARGET_NAME.$OUTPUT_SUFFIX" "$OUTPUT_DIR/macos"
cp -v "$path/build/$CONFIG/$TARGET_NAME.$OUTPUT_SUFFIX" ../../output/macos
mkdir -p ~/Library/Application\ Support/Corona/Simulator/Plugins/xyz/canardoux
cp -v    "$path/build/$CONFIG/$TARGET_NAME.$OUTPUT_SUFFIX" ~/Library/Application\ Support/Corona/Simulator/Plugins/xyz/canardoux
checkError
#cd "$path/CoronaShell"
rm -rf build/$CONFIG/CoronaShell.app
xcodebuild -project "$path/CoronaShell.xcodeproj" -configuration $CONFIG clean
checkError

xcodebuild -project "$path/CoronaShell.xcodeproj" -configuration $CONFIG build
checkError

cp  -a ../Corona    build/$CONFIG/CoronaShell.app/Contents/Resources/
mkdir -p build/$CONFIG/CoronaShell.app/Contents/Resources/Corona/xyz/canardoux
cp  -a build/$CONFIG/$TARGET_NAME.$OUTPUT_SUFFIX     build/$CONFIG/CoronaShell.app/Contents/Resources/Corona/xyz/canardoux
rm -rf "$OUTPUT_DIR"/macos/$TARGET_NAME.app
cp  -a build/$CONFIG/CoronaShell.app "$OUTPUT_DIR"/macos/$TARGET_NAME.app
rm -rf ../../output/macos/macos/$TARGET_NAME.app
cp  -a build/$CONFIG/CoronaShell.app ../../output/macos/


echo -e "\n\nYour output is in $OUTPUT_DIR/$TARGET_NAME.app\n"
