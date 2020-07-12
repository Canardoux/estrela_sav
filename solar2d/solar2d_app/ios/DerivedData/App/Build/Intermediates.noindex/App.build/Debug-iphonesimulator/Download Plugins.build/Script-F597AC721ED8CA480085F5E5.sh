#!/bin/sh

BUILDER_PATH="$CORONA_ROOT"/Corona/mac/bin/CoronaBuilder.app/Contents/MacOS/CoronaBuilder

"$BUILDER_PATH" plugins download ios "$PROJECT_DIR/../Corona/build.settings" "$PROJECT_DIR/CoronaApp.xcconfig" $CORONA_FORCE_LOAD

if [ $? -ne 0 ]
then
    echo "Exiting due to errors (above)"
    exit -1
fi

touch "$SRCROOT/../Corona"
