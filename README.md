# How to make a Universal Framework

### Info

This example uses Xcode Version 11.1 (11A1027).

## Add a new scheme

If you're using the Cocoapods you need to copy all the other settings under your scheme. Thats why we will duplicate our scheme instead of creating a new one.

Duplicate your scheme under Product → Scheme → Manage Schemes... menu. Make sure that shared box is selected.

Edit your schema name like below, we will use this naming convension in our script file:

```
YourProjectName-Universal
```

### Warning
This example uses the Cocoapods. CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. Thats why in the script file we're using the workspace instead of the target. So, if you have a project without a workspace please update your **xcodebuild** lines in script file with code below:

```
xcodebuild -target "${PROJECT_NAME}" 
```

something like this:

```
xcodebuild -target "${PROJECT_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build
```

## Run Script Action

Select **Project Target → Edit Schema → Archive → Post-actions → Press “+” → New Run Script Action**

Copy paste the script code below:

```
#!/bin/sh

echo "\n ⏱ Starting the Universal Framework work \n\n\n"

exec > /tmp/${PROJECT_NAME}_archive.log 2>&1

UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-Universal
IPHONEOS_FOLDER=${BUILD_DIR}/${CONFIGURATION}-iphoneos
IPHONESIMULATOR_FOLDER=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator

# Make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

# Next, work out if we're in SIMULATOR or REAL DEVICE

echo "\n\n\n 🚀 Step 1: Building for iphonesimulator"
xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build

echo "\n\n\n 🚀 Step 2: Building for iphoneos \n\n\n"
xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build

# Step 3. Copy the framework structure (from iphoneos build) to the universal folder
echo "\n\n\n 🗄 Step 3: Copy the framework structure for iphoneos"

cp -R "${IPHONEOS_FOLDER}/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/"

# Step 4. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory
BUILD_PRODUCTS="${SYMROOT}/../../../../Products"
echo "\n\n\n 🗄 Step 4: Copy the framework structure for iphonesimulator."
cp -R "${BUILD_PRODUCTS}/Release-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/." "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"

# Step 5. Create universal binary file using lipo and place the combined executable in the copied framework directory
echo "\n\n\n 🛠 Step 5: The LIPO Step"
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${IPHONESIMULATOR_FOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${IPHONEOS_FOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}"

# Step 6. Convenience step to copy the framework to the project's directory
echo "\n\n\n 🚛 Step 6 Copying to project directory"
yes | cp -Rf "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework" "${PROJECT_DIR}"

# Step 6. Convenience step to open the project's directory in Finder
open "${PROJECT_DIR}"

echo "\n\n\n 🏁 Completed."
echo "\n\n\n 🔍 For more details please check the /tmp/${PROJECT_NAME}_archive.log file. \n\n\n"

```

Under the **Provide Build Settings From** menu *YourProjectName* must be selected.

## Archive

Then run the Build > Archive on your Xcode.

The *Post Script* will be executed after the Archive is completed. And the Universal Framework would be generated and opened in project directory itself.

Thats All.
