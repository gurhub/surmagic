#!/bin/sh

echo "\n ⏱ Removing Unused Architectures \n\n\n"

exec > /tmp/${PROJECT_NAME}_archive.log 2>&1

FRAMEWORK="YOUR_FRAMEWORK_NAME"

FRAMEWORK_EXECUTABLE_PATH="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/$FRAMEWORK.framework/$FRAMEWORK"

EXTRACTED_ARCHS=()

for ARCH in $ARCHS

do

lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"

EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")

done

lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"

rm "${EXTRACTED_ARCHS[@]}"
rm "$FRAMEWORK_EXECUTABLE_PATH"
mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

echo "\n ⏱ Removing Unused Architectures \n\n\n"
echo "\n\n\n 🏁 Completed removing unused architectures from your fat framework."
echo "\n\n\n 🔍 For more details please check the /tmp/${PROJECT_NAME}_archive.log file. \n\n\n"
