# How to make a Universal Framework

### Info

This example uses:

* Xcode Version 11.1 (11A1027) 
* and the Cocoapods. 

**CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects.** 

That's why in the script file we're using the workspace instead of the target. So, if you have a project without a workspace please update your **xcodebuild** lines in the script file with code below:

```
xcodebuild -target "${PROJECT_NAME}" 
```

something like this:

```
xcodebuild -target "${PROJECT_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build
```

## Add a new scheme

If you're using the Cocoapods you need to copy all the other settings under your scheme. That's why we will duplicate our scheme instead of creating a new one.

Duplicate your scheme under Product → Scheme → Manage Schemes... menu. Make sure that the shared box is selected.

Edit your schema name like below, we will use this naming convention in our script file:

```
YourProjectName-Universal
```

## Run Script Action

Select **Project Target → Edit Schema → Archive → Post-actions → Press “+” → New Run Script Action**

Copy paste the script code below:

```
#!/bin/sh

echo "\n ⏱ Starting the Universal Framework work \n\n\n"

exec > /tmp/${PROJECT_NAME}_archive.log 2>&1

FRAMEWORK_NAME="${PROJECT_NAME}"
DEVICE_LIBRARY_PATH=${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework
SIMULATOR_LIBRARY_PATH=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${FRAMEWORK_NAME}.framework
UNIVERSAL_LIBRARY_DIR=${BUILD_DIR}/${CONFIGURATION}-Universal
ROW_STRING="\n##################################################################\n"

# Make sure the output directory exists
mkdir -p "${UNIVERSAL_LIBRARY_DIR}"

######################
# Step 1: Build Frameworks
######################

echo "${ROW_STRING}"
echo "\n\n\n 🚀 Step 1: Building for iphonesimulator"
echo "${ROW_STRING}"
xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build

echo "${ROW_STRING}"
echo "\n\n\n 🚀 Step 1: Building for iphoneos \n\n\n"
xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build



######################
# Step 3. Copy the frameworks
######################

echo "${ROW_STRING}"
echo "\n\n\n 🗄 Step 3: Copy the framework structure for iphoneos"
echo "${ROW_STRING}"

cp -R "${DEVICE_LIBRARY_PATH}" "${UNIVERSAL_LIBRARY_DIR}/"



######################
# Step 4. For Swift framework, Swiftmodule needs to be copied in the universal framework
######################

if [ -d "${SIMULATOR_LIBRARY_PATH}/Modules/${PROJECT_NAME}.swiftmodule/" ]; then

cp -f ${SIMULATOR_LIBRARY_PATH}/Modules/${PROJECT_NAME}.swiftmodule/* "${FRAMEWORK}/Modules/${PROJECT_NAME}.swiftmodule/" | echo

fi


if [ -d "${DEVICE_LIBRARY_PATH}/Modules/${PROJECT_NAME}.swiftmodule/" ]; then

cp -f ${DEVICE_LIBRARY_PATH}/Modules/${PROJECT_NAME}.swiftmodule/* "${FRAMEWORK}/Modules/${PROJECT_NAME}.swiftmodule/" | echo

fi



######################
# Step 5. Create the universal binary
######################

echo "${ROW_STRING}"
echo "\n\n\n 🛠 Step 5: The LIPO Step"
echo "${ROW_STRING}"

lipo -create -output "${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework/${PROJECT_NAME}" "${SIMULATOR_LIBRARY_PATH}/${PROJECT_NAME}" "${DEVICE_LIBRARY_PATH}/${PROJECT_NAME}"



######################
# Step 6. Copy the framework to the project's directory in project's directory
######################

echo "${ROW_STRING}"
echo "\n\n\n 🚛 Step 6 Copying in the project directory"
echo "${ROW_STRING}"

yes | cp -Rf "${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework" "${PROJECT_DIR}"



######################
# Step 6. Open the project's directory
######################

echo "${ROW_STRING}"
open "${PROJECT_DIR}"
echo "${ROW_STRING}"

echo "\n\n\n 🏁 Completed."
echo "\n\n\n 🔍 For more details please check the /tmp/${PROJECT_NAME}_archive.log file. \n\n\n"

```

Under the **Provide Build Settings From** menu *YourProjectName* must be selected.

## Archive

Then run the Build > Archive on your Xcode.

The *Post Script* will be executed after the Archive is completed. And the Universal Framework would be generated and opened in project directory itself.

Thats All.
