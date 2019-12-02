#!/bin/sh

######################
# Globals
######################
DEVICE_ARCH="appletvos"
DEVICE_SIM_ARCH="appletvsimulator"
FRAMEWORK_NAME="${PROJECT_NAME}"
DEVICE_LIBRARY_PATH=${BUILD_DIR}/${CONFIGURATION}-${DEVICE_ARCH}/${FRAMEWORK_NAME}.framework
SIMULATOR_LIBRARY_PATH=${BUILD_DIR}/${CONFIGURATION}-${DEVICE_SIM_ARCH}/${FRAMEWORK_NAME}.framework
UNIVERSAL_LIBRARY_DIR=${BUILD_DIR}/${CONFIGURATION}-Universal
ROW_STRING="\n##################################################################\n"

######################
# Starting logging
######################
exec > /tmp/${FRAMEWORK_NAME}_archive.log 2>&1
echo "\n ⏱ Starting the Universal Framework work... \n\n\n"

######################
# Echo the PATHS
######################

echo "DEVICE_LIBRARY_PATH: ${DEVICE_LIBRARY_PATH}"
echo "SIMULATOR_LIBRARY_PATH: ${SIMULATOR_LIBRARY_PATH}"
echo "UNIVERSAL_LIBRARY_DIR: ${UNIVERSAL_LIBRARY_DIR}"
echo "${ROW_STRING}"

# Make sure the output directory exists
mkdir -p "${UNIVERSAL_LIBRARY_DIR}"

######################
# Step 1: Build Frameworks
######################

echo "${ROW_STRING}"
echo "\n\n\n 🚀 Step 1: Building for ${DEVICE_SIM_ARCH}"
echo "${ROW_STRING}"
xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" -configuration ${CONFIGURATION} -sdk ${DEVICE_SIM_ARCH} ONLY_DEVICE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build

echo "${ROW_STRING}"
echo "\n\n\n 🚀 Step 1: Building for ${DEVICE_ARCH} \n\n\n"
xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${TARGET_NAME}" ONLY_DEVICE_ARCH=NO -configuration ${CONFIGURATION} -sdk ${DEVICE_ARCH}  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build



######################
# Step 2. Copy the frameworks
######################

echo "${ROW_STRING}"
echo "\n\n\n 📦 Step 2: Copy the framework structure for ${DEVICE_ARCH}"
echo "${ROW_STRING}"

cp -R "${DEVICE_LIBRARY_PATH}" "${UNIVERSAL_LIBRARY_DIR}/"



######################
# Step 3. Create the universal binary
######################

echo "${ROW_STRING}"
echo "\n\n\n 🛠 Step 3: The LIPO Step"
echo "${ROW_STRING}"

lipo -create "${SIMULATOR_LIBRARY_PATH}/${FRAMEWORK_NAME}" "${DEVICE_LIBRARY_PATH}/${FRAMEWORK_NAME}" -output "${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"



######################
# Step 4. Copy the Swiftmodules. 
# 👉 This step is necessary only if your project is Swift. For the Swift framework, Swiftmodule needs to be copied in the universal framework. 
######################
echo "${ROW_STRING}"
echo "\n\n\n 📦 Step 4: Copy the Swiftmodules"
echo "${ROW_STRING}"


if [ -d "${SIMULATOR_LIBRARY_PATH}/Modules/${FRAMEWORK_NAME}.swiftmodule/" ]; then

cp -f ${SIMULATOR_LIBRARY_PATH}/Modules/${FRAMEWORK_NAME}.swiftmodule/* "${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/" | echo

fi


if [ -d "${DEVICE_LIBRARY_PATH}/Modules/${FRAMEWORK_NAME}.swiftmodule/" ]; then

cp -f ${DEVICE_LIBRARY_PATH}/Modules/${FRAMEWORK_NAME}.swiftmodule/* "${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/" | echo

fi



######################
# Step 5. Remove the existing copy of the Universal framework and copy the framework to the project's directory
######################

echo "${ROW_STRING}"
echo "\n\n\n 🚛 Step 5 Copying in the project directory"
echo "${ROW_STRING}"

rm -rf "${PROJECT_DIR}/${FRAMEWORK_NAME}.framework"
yes | cp -Rf "${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework" "${PROJECT_DIR}"



######################
# Step 6. Open the project's directory
######################

echo "${ROW_STRING}"
open "${PROJECT_DIR}"
echo "${ROW_STRING}"



######################
# Step 7. Open the log file on Console application
######################

echo "${ROW_STRING}"
open /tmp/${FRAMEWORK_NAME}_archive.log
echo "${ROW_STRING}"

echo "\n\n\n 🔍 For more details please check the /tmp/${FRAMEWORK_NAME}_archive.log file. \n\n\n"
echo "\n\n\n 🏁 Completed!"

