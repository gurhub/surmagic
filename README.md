# How to make a Universal Framework

## Add a new scheme

Create new scheme, Select Project Target → New Schema

Enter a new schema name — YourProjectName-Universal


## Run Script Action

Select **Project Target → Edit Schema → Archive → Post-actions → Press “+” → New Run Script Action**

Copy paste the script code below:

```
#!/bin/sh

exec > /tmp/${PROJECT_NAME}_archive.log 2>&1

UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-Universal

# Make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

# Next, work out if we're in SIMULATOR or REAL DEVICE
xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build

xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build

# Step 2. Copy the framework structure (from iphoneos build) to the universal folder
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/"
# Step 3. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory
BUILD_PRODUCTS="${SYMROOT}/../../../../Products"
cp -R "${BUILD_PRODUCTS}/Debug-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/." "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"

# Step 4. Create universal binary file using lipo and place the combined executable in the copied framework directory
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_PRODUCTS}/Debug-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}"

# Step 5. Convenience step to copy the framework to the project's directory
echo "Copying to project dir"
yes | cp -Rf "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework" "${PROJECT_DIR}"

# Step 6. Convenience step to open the project's directory in Finder
open "${PROJECT_DIR}"

fi
```

Under the **Provide Build Settings From** menu *YourProjectName* must be selected.

## Archive

Then run the Build > Archive on your Xcode.

The *Post Script* will be executed after the Archive is completed. And the Universal Framework would be generated and opened in project directory itself.

Thats All.

## Errors 

The script also will log all the steps and copy the framework file in your project folder. You can check log file with command line below:

```
cat /tmp/ApacMiddlewareClient_archive.log
```
