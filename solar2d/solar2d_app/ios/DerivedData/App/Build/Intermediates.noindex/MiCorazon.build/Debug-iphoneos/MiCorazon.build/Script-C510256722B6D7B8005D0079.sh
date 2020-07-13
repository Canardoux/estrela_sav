#!/bin/sh
# Type a script or drag a script file from your workspace to insert its path.
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

PLUGINS_DIR="${HOME}/Library/Application Support/Corona/Simulator/Plugins"
#PLUGINS_DIR2="${HOME}/Sites/download/ios"

mkdir -p "$PLUGINS_DIR"
checkError
#mkdir -p "$PLUGINS_DIR2"
#checkError

cp -v $CONFIGURATION_BUILD_DIR/$FULL_PRODUCT_NAME "$PLUGINS_DIR"/.
checkError
#cp -v "${PROJECT_DIR}/metadata.lua"  "${PLUGINS_DIR}"/.
#checkError
#cd "$PLUGINS_DIR"/
#tar -czf ~/Sites/download/ios/micorazon.tgz $FULL_PRODUCT_NAME metadata.lua
#checkError

