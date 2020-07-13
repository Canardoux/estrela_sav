#!/bin/bash -e


path=$(dirname "$0")

OUTPUT_DIR=$1
TARGET_NAME=MiCorazon
OUTPUT_SUFFIX=a
CONFIG=Release


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
    	OUTPUT_DIR=../output
	echo "OUTPUT DIR = $OUTPUT_DIR\n"
fi

pushd "$OUTPUT_DIR" > /dev/null
dir=$(pwd)
OUTPUT_DIR=$dir
popd > /dev/null

echo "OUTPUT_DIR: $OUTPUT_DIR"


cd ios
./build.sh $OUTPUT_DIR
checkError

cd ../android
./build.sh  $OUTPUT_DIR
checkError

cd ../mac
./build.sh  $OUTPUT_DIR
checkError

cd ..

echo "Your outputs are in " $OUTPUT_DIR
exit 0
