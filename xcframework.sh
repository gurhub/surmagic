#! /bin/sh -e

#
#
#   Created by Muhammed Gurhan Yerlikaya on 11.11.2020.
#   
#   * Repo: https://github.com/gurhub/universal-framework
#
#

##################################################################
#
# GLOBAL FUNCTIONS
#
##################################################################

# REGULAR COLORS

COLOR_OFF() {
	echo "\033[0m"
}

WHITE() {
    echo "\033[0;37m"
}

BLACK() {
    echo "\033[0;30m"
}

RED() {
    echo "\033[0;31m"
}

GREEN() {
    echo "\033[0;32m"
}

YELLOW() {
    echo "\033[0;33m"
}

BLUE() {
    echo "\033[0;34m"
}

CYAN() {
    echo "\033[0;36m"
}

PURPLE() {
    echo "\033[0;35m"
}

TOPROW() {
	echo "\n##################################################################\n"
}

BOTTOMROW() {
	echo "\n##################################################################\n"
}

STEPSEPERATOR() {
	echo "\n##################################################################\n"
}

##################################################################
#
# USER PARAMETERS
#
##################################################################

# Output Path
OUTPUT_DIR_PATH=$1
# Xcode Project Name
PROJECT_NAME=$2
# Framework Name
FRAMEWORK_NAME=$3

##################################################################
#
# CONSTANTS
#
##################################################################

kEXAMPLERUN=" 💡 Example usage: ./xcframework.sh {OUTPUT_DIR_PATH} {PROJECT_NAME} {FRAMEWORK_NAME}"
kERROR=" ❌ Error:"

##################################################################
#
# INPUT PARAMETERS LOGIC
#
##################################################################

if [[ -z $1 ]]; then
	TOPROW
	RED
	echo "${kERROR} Output directory was not set.\n"
	YELLOW
	echo "${kEXAMPLERUN}"
	COLOR_OFF
	BOTTOMROW
	exit 1;
fi

if [[ -z $2 ]]; then
	TOPROW
	RED
	echo " ${kERROR} Project name was not set.\n"
	YELLOW
	echo "${kEXAMPLERUN}"
	COLOR_OFF
	BOTTOMROW
	exit 1;
fi

if [[ -z $3 ]]; then
	TOPROW
	RED
	echo " ${kERROR} Framework name was not set.\n"
	YELLOW
	echo "${kEXAMPLERUN}"
	COLOR_OFF
	BOTTOMROW
	exit 1;
fi

##################################################################
#
# PRINTS THE ARCHIVE PATH FOR THE SIMULATOR
#
##################################################################

function archivePathSimulator {
	local DIR=${OUTPUT_DIR_PATH}/archives/"${1}-SIMULATOR"
	echo "${DIR}"
}

##################################################################
#
# PRINTS THE ARCHIVE PATH FOR THE DEVICE
#
##################################################################

function archivePathDevice {
	local DIR=${OUTPUT_DIR_PATH}/archives/"${1}-DEVICE"
	echo "${DIR}"
}

##################################################################
#
# ARCHIVE FUNCTION
#
# Takes 3 params
#
# 1st == SCHEME
# 2nd == destination
# 3rd == archivePath
#
##################################################################


function archive {
	echo "🏁 Starts archiving the scheme: ${1} for destination: ${2};\n"
	echo "📝 Archive path: ${3}.xcarchive"
	xcodebuild archive \
	-project ${PROJECT_NAME}.xcodeproj \
	-scheme ${1} \
	-destination "${2}" \
	-archivePath "${3}" \
	SKIP_INSTALL=NO \
	BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcpretty
}

##################################################################
#
# ARCHIVE FUNCTION 
# BUILD ARCHIVE FOR IOS/TVOS SIMULATOR & DEVICE
#
##################################################################

function buildArchive {
	SCHEME=${1}
	archive $SCHEME "generic/platform=iOS Simulator" $(archivePathSimulator $SCHEME)
	archive $SCHEME "generic/platform=iOS" $(archivePathDevice $SCHEME)
	archive "${SCHEME}TV" "generic/platform=tvOS Simulator" $(archivePathSimulator "${SCHEME}TV")
	archive "${SCHEME}TV" "generic/platform=tvOS" $(archivePathDevice "${SCHEME}TV")
}

##################################################################
#
# XCFRAMEWORK FUNCTION 
# CREATES XC FRAMEWORK
#
##################################################################

function createXCFramework {
	FRAMEWORK_ARCHIVE_PATH_POSTFIX=".xcarchive/Products/Library/Frameworks"
	FRAMEWORK_SIMULATOR_DIR="$(archivePathSimulator $1)${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"
	FRAMEWORK_DEVICE_DIR="$(archivePathDevice $1)${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"
	FRAMEWORK_SIMULATOR_TV_DIR="$(archivePathSimulator $1TV)${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"
	FRAMEWORK_DEVICE_TV_DIR="$(archivePathDevice $1TV)${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"
	xcodebuild -create-xcframework \
	-framework ${FRAMEWORK_SIMULATOR_DIR}/${1}.framework \
	-framework ${FRAMEWORK_DEVICE_DIR}/${1}.framework \
	-framework ${FRAMEWORK_SIMULATOR_TV_DIR}/${1}TV.framework \
	-framework ${FRAMEWORK_DEVICE_TV_DIR}/${1}TV.framework \
	-output ${OUTPUT_DIR_PATH}/xcframeworks/${1}.xcframework
}

##################################################################
#
# CREATE THE FRAMEWORK
#
##################################################################

STEPSEPERATOR
echo "🚀 Process Started"
STEPSEPERATOR
echo "📂 Evaluating Output Directory"
STEPSEPERATOR
echo "🧹 Cleaning the dir: ${OUTPUT_DIR_PATH}"
STEPSEPERATOR

##################################################################
#
# CLEANING
#
##################################################################

rm -rf $OUTPUT_DIR_PATH

PURPLE
echo "📝 Archive $FRAMEWORK_NAME"
COLOR_OFF

##################################################################
#
# BUILD
#
##################################################################

buildArchive ${FRAMEWORK_NAME}

CYAN
echo "🗜 Now Creating -> $FRAMEWORK_NAME.xcframework"
COLOR_OFF

createXCFramework ${FRAMEWORK_NAME}
mv ${OUTPUT_DIR_PATH}/xcframeworks/${FRAMEWORK_NAME}.xcframework ${OUTPUT_DIR_PATH}/${FRAMEWORK_NAME}.xcframework
rm -rf $OUTPUT_DIR_PATH/xcframeworks
rm -rf $OUTPUT_DIR_PATH/archives

##################################################################
#
# DONE
#
##################################################################
