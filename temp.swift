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

// MARK: - USER PARAMETERS

/// Output Path
var OUTPUT_DIR_PATH: String

/// Framework Name
var FRAMEWORK_NAME: String

/// User decision of including Targets to the XCFramework
var addIOS:  Bool
var addtvOS: Bool

/// Xcode iOS Project Name
var iOS_PROJECT_NAME: String

/// Xcode iOS Project's Scheme Name
var iOS_SCHEME_NAME: String

/// Xcode tvOS Project Name
var tvOS_PROJECT_NAME: String

/// Xcode tvOS Project's Scheme Name
var tvOS_SCHEME_NAME: String

// MARK: - Logic

parseParameters()

/// Ask user for **OUTPUT_DIR_PATH**
OUTPUT_DIR_PATH = askDirectoryName()

/// Ask user for **FRAMEWORK_NAME**
FRAMEWORK_NAME = askFrameworkName()

/// Ask user for iOS Decision
addIOS = askDecision(for: "iOS")

if (addIOS) {
    iOS_PROJECT_NAME = askProjectName(for: "iOS")
    iOS_SCHEME_NAME = askSchemeName(for: "iOS")
    print(Colors.blue + "\n 📦 iOS framework name: \(iOS_PROJECT_NAME)" + Colors.reset)
} else {
    print(Colors.red + "\n\t ⏭  Skipped the iOS project option." + Colors.reset)
}

addtvOS = askDecision(for: "tvOS")

if (addtvOS) {
    tvOS_PROJECT_NAME = askProjectName(for: "tvOS")
    print(Colors.blue + "\n 📦 tvOS framework name: \(tvOS_PROJECT_NAME)" + Colors.reset)
} else {
    print(Colors.red + "\n\t ⏭  Skipped the tvOS project option." + Colors.reset)
}

if (addIOS != false || addtvOS != false) {
    print("\n\tCoooking.")
    
    

} else {
    Draw.topRow()
    print(kERROR)
    print(kNO_PARAMETERS)
    print(kEXAMPLE_RUN)
    Draw.bottomRow()
    exit(1)
}

// MARK: - Methods

/// Parse the Universal.plist file for the parameters.
private func parseParameters() {
    do {
        let cwd = FileManager.default.currentDirectoryPath
        let path = "./universal/universal.plist"
        let plistURL = URL(fileURLWithPath: path)
        let contents = try String(contentsOfFile: plistURL.path, encoding: .utf8)
        print(contents)
        

        let data = try Data(contentsOf: plistURL)
        let plistDecoder = PropertyListDecoder()
        let parameters = try plistDecoder.decode([ClientParameters].self, from: data)
        print(parameters)
    
        /*
        guard let plistFilepath = URL(fileURLWithPath: ".") else {
            let errorMessage = "Couln't find the  reading the universal.plist file:" + "\(error.localizedDescription)"
            print("\(errorMessage)")
            exit(1)
        }
        
        let data = try Data(contentsOf: plistFilepath)
        let plistDecoder = PropertyListDecoder()
        clientParameters = try plistDecoder.decode(ClientParameters.self, from: data)
         */
    } catch {
        let errorMessage = "\(error.localizedDescription)"
        print("\(errorMessage)")
        exit(1)
    }
}

/// Prints the Archive Path for the Simulator
//func archivePathSimulator() {
//    let dir = "\(OUTPUT_DIR_PATH)/archives/\(iOS_SCHEME_NAME)-SIMULATOR"
//    print(dir)
//}

func askDirectoryName() -> String {
    print(Colors.yellow + "\n 📝 Please Enter the Output Directory Name: " + Colors.magenta, terminator: "")
    return readLine(strippingNewline: true) ?? kDEFAULT_NAME
}

func askFrameworkName() -> String {
    print(Colors.yellow + "\n 📝 Type your desired Framework name: " + Colors.magenta, terminator: "")
    return readLine(strippingNewline: true) ?? kDEFAULT_NAME
}

func askDecision(for os: String) -> Bool {
    print(Colors.yellow + "\n 📝 Do you want add \(os) target to your Framework: yes/no, (or Press Enter for Skip): " + Colors.magenta, terminator: "")
    let answer = readLine(strippingNewline: true) ?? "yes"
    
    return yesOrNo(answer: answer)
}

func askProjectName(for os: String) -> String {
    print(Colors.yellow + "\n 📝 Type your \(os) project File name: " + Colors.magenta, terminator: "")
    return readLine(strippingNewline: true) ?? kDEFAULT_NAME
}

func askSchemeName(for os: String) -> String {
    print(Colors.yellow + "\n 📝 Type your \(os) project's Scheme name: " + Colors.magenta, terminator: "")
    return readLine(strippingNewline: true) ?? kDEFAULT_NAME
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

// MARK: - CONSTANTS
// TODO: - Move to another file

struct Draw {
    static func topRow() {
        print(Colors.cyan + "\n\t##################################################################\n" + Colors.reset)
    }

    static func bottomRow() {
        print(Colors.cyan + "\n\t##################################################################\n" + Colors.reset)
    }

    static func stepSeperator() {
        print(Colors.cyan + "\n\t##################################################################\n" + Colors.reset)
    }
}

struct Colors {
    static let reset = "\u{001B}[0;0m"
    static let black = "\u{001B}[0;30m"
    static let red = "\u{001B}[0;31m"
    static let green = "\u{001B}[0;32m"
    static let yellow = "\u{001B}[0;33m"
    static let blue = "\u{001B}[0;34m"
    static let magenta = "\u{001B}[0;35m"
    static let cyan = "\u{001B}[0;36m"
    static let white = "\u{001B}[0;37m"
}

let kEXAMPLE_RUN = Colors.yellow + "\n\t 💡 Example usage: ./xcframework.sh {OUTPUT_DIR_PATH} {PROJECT_NAME} {FRAMEWORK_NAME}" + Colors.reset
let kERROR = Colors.red + "\n\t ❌ Error:" + Colors.reset
let kNO_PARAMETERS = Colors.yellow + "\n\t ⚠️  At least you sould enter 1 project for creating XCFramework." + Colors.reset
let kPARAMETERS_FILE_NAME = "/universal/universal.plist"
let kDEFAULT_NAME = "anonymous"

public class ClientParameters: Codable {
    
    // MARK: Types
    enum CodingKeys: String, CodingKey {
        case init2 = "init2"
        case login = "login"
        case ticketURL = "ticket_url"
        case username = "username"
        case memberId = "memberId"
        case password = "password"
        case goldDRMTicket = "gold_drm_ticket"
    }
    
    // MARK: Properties
    
    let init2: String
    let login: String
    let ticketURL: String
    let username: String
    let memberId: String
    let password: String
    let goldDRMTicket: String
}
