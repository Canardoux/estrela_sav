#!/bin/sh
# Type a script or drag a script file from your workspace to insert its path.
cp  -a "$PROJECT_DIR/../Corona"    "$BUILT_PRODUCTS_DIR/$TARGET_NAME.app/Contents/Resources/"
mkdir -p "$BUILT_PRODUCTS_DIR/$TARGET_NAME.app/Contents/Resources/Corona/xyz/canardoux"
cp  -a "$BUILT_PRODUCTS_DIR/micorazon.dylib"     "$BUILT_PRODUCTS_DIR/$TARGET_NAME.app/Contents/Resources/Corona/xyz/canardoux"

