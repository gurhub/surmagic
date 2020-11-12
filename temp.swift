#!/usr/bin/env swift

//
//  universal
//
//  Created by Muhammed Gurhan Yerlikaya on 11.11.2020.
//  Copyright © 2020 https://github.com/gurhub/universal.
//


import Foundation

/*
let ls = Process()
ls.executableURL = URL(fileURLWithPath: "/usr/bin/env")
ls.arguments = ["ls", "-lat"]
do{
  try ls.run()
} catch { 
	//TODO: write catch for executing command
}

*/

// ##################################################################
//
// USER PARAMETERS
//
// ##################################################################

let defaultName = "anonymous"

/// Output Path
var OUTPUT_DIR_PATH: String

/// Framework Name
var FRAMEWORK_NAME: String

/// User decision of including Targets to the XCFramework
var addIOS:  Bool
var addtvOS: Bool

/// Xcode iOS Project Name
var iOS_PROJECT_NAME: String

/// Xcode tvOS Project Name
var tvOS_PROJECT_NAME: String

// MARK: - Logic

/// Ask user for **OUTPUT_DIR_PATH**
OUTPUT_DIR_PATH = askDirectoryName()

/// Ask user for **FRAMEWORK_NAME**
FRAMEWORK_NAME = askFrameworkName()

/// Ask user for iOS Decision
addIOS = askDecision(for: "iOS")

if (addIOS) {
    iOS_PROJECT_NAME = askProjectName(for: "iOS")
    print("Will create iOS framework with name: \(iOS_PROJECT_NAME)")
} else {
    print("Skipped the iOS project option.")
}

addtvOS = askDecision(for: "tvOS")

if (addtvOS) {
    tvOS_PROJECT_NAME = askProjectName(for: "tvOS")
    print("Will create tvOS framework with name: \(tvOS_PROJECT_NAME)")
} else {
    print("Skipped the tvOS project option.")
}

if (addIOS == false && addtvOS == false) {
    print("At least you sould enter 1 project for creating XCFramework.")
    exit(1)
} else {
    print("Coooking.")
}

// MARK: - Methods

func askDirectoryName() -> String {
    print("Please Enter the Output Directory Name:")
    return readLine(strippingNewline: true) ?? defaultName
}

func askFrameworkName() -> String {
    print("Type your desired Framework name:")
    return readLine(strippingNewline: true) ?? defaultName
}

func askDecision(for os: String) -> Bool {
    print("Do you want add \(os) target to your Framework: yes/no, (or Press Enter for Skip):")
    let answer = readLine(strippingNewline: true) ?? "yes"
    
    return yesOrNo(answer: answer)
}

func askProjectName(for os: String) -> String {
    print("Type your \(os) project (target) name:")
    return readLine(strippingNewline: true) ?? defaultName
}

func yesOrNo(answer: String?) -> Bool {
    guard let answer = answer else {
        return true
    }

	if answer == "y" || answer == "yes" {
        return true
    } else if answer == "n" || answer == "no" {
        return false
    } else {
        return false
	}
}
