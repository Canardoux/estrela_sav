#!/bin/sh -e

TARGET_NAME=MiCorazon
CONFIG=Debug
DEFAULT_OUTPUT=~/Sites/download

#--------------------------------------------------

path=$(dirname "$0")
OUTPUT_DIR=$1
OUTPUT_SUFFIX=a

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


mkdir -p $OUTPUT_DIR/ios 2>/dev/null
mkdir -p ../../output/ios 2>/dev/null

BUILD_PATH="$path"/build

# Clean
xcodebuild -project "$path/MiCorazon.xcodeproj" -configuration $CONFIG clean
checkError

# iOS
xcodebuild -project "$path/MiCorazon.xcodeproj" -configuration $CONFIG -arch arm64 -arch armv7 -arch armv7s only_active_arch=no defines_module=yes  -sdk iphoneos
checkError

# iOS-sim
xcodebuild -project "$path/MiCorazon.xcodeproj" -configuration $CONFIG -arch x86_64 -arch i386 only_active_arch=no defines_module=yes -sdk iphonesimulator
checkError

# create universal binary
lipo -create "$path"/build/$CONFIG-iphoneos/lib$TARGET_NAME.$OUTPUT_SUFFIX "$path"/build/$CONFIG-iphonesimulator/lib$TARGET_NAME.$OUTPUT_SUFFIX -output "$BUILD_PATH"/lib$TARGET_NAME.$OUTPUT_SUFFIX
checkError

cp "$path"/metadata.lua "$BUILD_PATH"/
checkError

cp "$BUILD_PATH"/lib$TARGET_NAME.$OUTPUT_SUFFIX "$OUTPUT_DIR/ios"/
cp "$BUILD_PATH"/lib$TARGET_NAME.$OUTPUT_SUFFIX ../../output/ios/
cd  "$BUILD_PATH"/
tar cvzf "$OUTPUT_DIR/ios"/micorazon.tgz metadata.lua lib$TARGET_NAME.$OUTPUT_SUFFIX
checkError
tar cvzf ../../../output/ios/micorazon.tgz metadata.lua lib$TARGET_NAME.$OUTPUT_SUFFIX
checkError
cd "$path"

echo '--------------------------------------------------------------------------------------------------------------------'

# The iOS APP
# -----------

# copy corona plugin structure

build_plugin_structure() {

	PLUGIN_DEST=$1
	mkdir -p "$PLUGIN_DEST"
	PLATFORM=$2
	ARCH=$3

	cp "$path/build/$CONFIG-$PLATFORM/lib$TARGET_NAME.$OUTPUT_SUFFIX" "$PLUGIN_DEST/"
	cp "$path"/metadata.lua "$PLUGIN_DEST/"

	if ls "$path/build/$CONFIG-$PLATFORM/"*.framework 1> /dev/null 2>&1; then
		echo "Copying bult frameworks for $PLATFORM"
		mkdir -p "$PLUGIN_DEST"/resources/Frameworks
		"$(xcrun -f rsync)"  --exclude _CodeSignature --exclude .DS_Store --exclude CVS --exclude .svn --exclude .git --exclude .hg --exclude Headers --exclude PrivateHeaders --exclude Modules -resolve-src-symlinks "$path/build/$CONFIG-$PLATFORM"/*.framework  "$PLUGIN_DEST"/resources/Frameworks
	else
		echo "No built frameworks on $path/build/$CONFIG-$PLATFORM/"
	fi


	if ls "$path"/EmbeddedFrameworks/*.framework 1> /dev/null 2>&1; then
		echo "Copying Embedded frameworks frameworks for $PLATFORM:"

		for f in "$path"/EmbeddedFrameworks/*.framework; do
			FRAMEWORK_NAME=$(basename "$f")
			BIN_NAME=${FRAMEWORK_NAME%.framework}
			SRC_BIN="$f"/$BIN_NAME

			if [[ $(file "$SRC_BIN" | grep -c "ar archive") -ne 0 ]]; then
				echo " - $FRAMEWORK_NAME: is a static Framework, extracting."

				DEST_BIN="$PLUGIN_DEST"/$FRAMEWORK_NAME/$BIN_NAME
				"$(xcrun -f rsync)"  --exclude '*.xcconfig' --exclude _CodeSignature --exclude .DS_Store --exclude CVS --exclude .svn --exclude .git --exclude .hg --exclude Headers --exclude PrivateHeaders --exclude Modules -resolve-src-symlinks "$f"  "$PLUGIN_DEST"
				rm "$DEST_BIN"
				lipo "$SRC_BIN" $ARCH -o "$DEST_BIN.tmp"
				$(xcrun -f bitcode_strip) "$DEST_BIN.tmp" -r -o "$DEST_BIN"
				rm "$DEST_BIN.tmp"
			else
				echo " + $FRAMEWORK_NAME: embedding"
				
				mkdir -p "$PLUGIN_DEST"/resources/Frameworks
				DEST_BIN="$PLUGIN_DEST"/resources/Frameworks/$FRAMEWORK_NAME/$BIN_NAME
				"$(xcrun -f rsync)"  --exclude '*.xcconfig' --exclude _CodeSignature --exclude .DS_Store --exclude CVS --exclude .svn --exclude .git --exclude .hg --exclude Headers --exclude PrivateHeaders --exclude Modules -resolve-src-symlinks "$f"  "$PLUGIN_DEST"/resources/Frameworks
				rm "$DEST_BIN"
				lipo "$SRC_BIN" $ARCH -o "$DEST_BIN.tmp"
				$(xcrun -f bitcode_strip) "$DEST_BIN.tmp" -r -o "$DEST_BIN"
				rm "$DEST_BIN.tmp"
			fi
		done
	else
		echo "No 3rd party frameworks on $path/EmbeddedFrameworks/"
	fi
}

build_plugin_structure "$BUILD_PATH/BuiltPlugin/iphone" iphoneos  " -extract armv7 -extract  arm64 "
build_plugin_structure "$BUILD_PATH/BuiltPlugin/iphone-sim" iphonesimulator  " -extract i386  -extract  x86_64 "

echo '---------------------------------------------------------------------------------------------------------------------'

# Create the MiCorazonApp.app
# ---------------------------
#xcodebuild -project "$path/MiCorazonApp.xcodeproj" -configuration $CONFIG build
#checkError
#cp -a "$path"/build/$CONFIG-iphoneos/MiCorazonApp.app "$BUILD_PATH"

# Create the MiCorazonApp.ipa
# ---------------------------
xcodebuild -project "$path/MiCorazonApp.xcodeproj" -scheme MiCorazonApp -sdk iphoneos -configuration AppStoreDistribution archive -archivePath "$path"/build/MiCorazon.xcarchive -arch arm64 -arch armv7 only_active_arch=no
checkError
xcodebuild -exportArchive -archivePath "$path/build/MiCorazon.xcarchive" -exportOptionsPlist "$path/MiCorazonApp-Info.plist"      -exportPath "$path"/build
checkError

cp -a "$path"/build/MiCorazonApp.ipa "$OUTPUT_DIR/ios"
cp -a "$path"/build/MiCorazonApp.ipa "../../output/ios"

echo "\n\noutputs are in :\n" 
echo "$OUTPUT_DIR"/ios/MiCorazonApp.ipa
echo "$OUTPUT_DIR/ios/micorazon.tgz\n"


