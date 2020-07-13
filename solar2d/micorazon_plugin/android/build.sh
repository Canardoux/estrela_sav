#!/bin/sh


TARGET_NAME=MiCorazon
CONFIG=debug
DEFAULT_OUTPUT=~/Sites/download

#--------------------------------------------------

path=$(dirname "$0")
OUTPUT_DIR=$1
OUTPUT_SUFFIX=xxx


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
pushd "$path" > /dev/null
dir=$(pwd)
path=$dir
popd > /dev/null

if [ -z "$OUTPUT_DIR" ]
then
    OUTPUT_DIR="$DEFAULT_OUTPUT"
fi

pushd "$OUTPUT_DIR" > /dev/null
dir=$(pwd)
OUTPUT_DIR=$dir
popd > /dev/null

echo "\n\nOUTPUT_DIR:= $OUTPUT_DIR\n\n"


#mkdir -p app/build/outputs/apk/debug 2>/dev/null
rm -rf app/build/outputs/apk/*


./gradlew assemble
checkError

./gradlew exportPluginJar
checkError


mkdir -p $OUTPUT_DIR/android 2>/dev/null
mkdir -p ../../output/android 2>/dev/null


cp -a app/build/outputs/apk "$OUTPUT_DIR"/android
cp -a app/build/outputs/apk ../../output/android

cp -a plugin/build/outputs/aar "$OUTPUT_DIR"/android
cp -a plugin/build/outputs/aar ../../output/android

cp metadata.lua plugin/build/outputs/aar
cd plugin/build/outputs/aar

unzip -f plugin-$CONFIG.aar


pwd
echo tar cvzf $path/../../output/android/micorazon.tgz metadata.lua classes.jar
tar cvzf $path/../../output/android/micorazon.tgz metadata.lua classes.jar
tar cvzf "$OUTPUT_DIR"/android/micorazon.tgz metadata.lua classes.jar
cd $path

echo "Your ouputs are in " "$OUTPUT_DIR"/android
