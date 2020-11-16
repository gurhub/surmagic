#!/usr/bin/env swift

//
//  universal
//
//  Created by Muhammed Gurhan Yerlikaya on 11.11.2020.
//  Copyright © 2020 https://github.com/gurhub/universal.
//

import Foundation

// MARK: - Parameters

/// Universalfile
var universalfile: Universalfile


// MARK: - Logic

mainLogic()

// MARK: - Methods

/// Main logic of the application.
private func mainLogic() {
    parseParameters()
}

private func remove(_ directory: String) {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    task.arguments = ["rm", "-rf", directory]
    
    do {
        try task.run()
        task.waitUntilExit()
        
        print(Colors.green + "\n 🗑  Cleaned output directory.\n" + Colors.reset)
        
    } catch {
        exit(with: nil)
    }
}

private func create(_ directory: String) {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    task.arguments = ["mkdir", directory]
    
    do {
        try task.run()
        task.waitUntilExit()
        
        print(Colors.green + "\n 📂 Created output directory.\n" + Colors.reset)
        
    } catch {
        exit(with: nil)
    }
}

private func reset(_ directories: [String]) {
    for directory in directories {
        // remove(directory)
        //#warning("LIVE: Open reset method above the line.")
        create(directory)
    }
}

private func archive(with target: Target, to directory: String) {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    var directories = [String]()
    
    let deviceArchivePath = "./\(directory)/\(target.sdk).xcarchive"
    directories.append(deviceArchivePath)
 
    /// reset directories
    reset(directories)
    
    /// archive
    var arguments:[String] = [String]()
    arguments.append("xcodebuild")
    arguments.append("-quiet")
    arguments.append("archive")
    
    if let workspace = target.workspace {
        arguments.append("-workspace")
        arguments.append(workspace)
    } else if let project = target.project {
        arguments.append("-project \(project)")
        arguments.append(project)
    } else {
        print(Colors.red + "\n ⚠️ Missing parameter for the target. Please re-check the parameters below:\n \(target.desc) \n." + Colors.reset)
        // continue
        return
    }
    
    arguments.append("-sdk")
    arguments.append(target.sdk.description)

    arguments.append("-scheme")
    arguments.append(target.scheme)
    
    arguments.append("-archivePath")
    arguments.append(directory)

    arguments.append("SKIP_INSTALL=NO")
    
    task.arguments = arguments
    
    print(Colors.blue + "\n 📦 Archiving for the \(target.sdk) SDK: \n \(arguments))" + Colors.reset)
    
    do {
        try task.run()
        task.waitUntilExit()
        
        print(Colors.green + "\n ✅ Archiving completed for the target: \(target.sdk) \n" + Colors.reset)
        
    } catch { //TODO: write catch for executing command
        exit(with: nil)
    }
}

private func archive(with targets: [Target], to directory: String) {
    for target in targets {
        archive(with: target, to: directory)
    }

    if targets.count > 0 {
        print(Colors.green + "\n ✅  Archive completed for targets." + Colors.reset)
    }
}

private func createXCFramework(with universalfile: Universalfile) {
    // STEPS
    // 1 createXCFramework ${FRAMEWORK_NAME}
    // 2 mv ${OUTPUT_DIR_PATH}/xcframeworks/${FRAMEWORK_NAME}.xcframework ${OUTPUT_DIR_PATH}/${FRAMEWORK_NAME}.xcframework
    // 3 rm -rf $OUTPUT_DIR_PATH/xcframeworks
    // 4 rm -rf $OUTPUT_DIR_PATH/archives

    /*
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
    */

    guard let targets = universalfile.targets else { return }

    let directory = universalfile.output_path
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
     
    /// archive
    var arguments:[String] = [String]()
    arguments.append("xcodebuild")
    //arguments.append("-quiet")
    arguments.append("-create-xcframework")
    
    // Frameworks
    for target in targets {
        let path = "./\(directory)/\(target.sdk).xcarchive"
        arguments.append("-framework")
        arguments.append(path)    
    }
    
    // Output
    let output = "./\(directory)/xcframeworks/\(universalfile.framework).xcframework"
    arguments.append("-output")
    arguments.append(output)
    
    task.arguments = arguments

    print(Colors.blue + "\n 🗜 Creating XCFramework from all targets. \n \(arguments))" + Colors.reset)
    
    do {
        try task.run()
        task.waitUntilExit()
        
        print(Colors.green + "\n\t 🥳 Successfully created a XCFramework on the location: \(output) \n" + Colors.reset)
    } catch { //TODO: write catch for executing command
        exit(with: nil)
    }
}

/// Parse the Universal.plist file for the parameters.
private func parseParameters() {
    do {
        //let cwd = FileManager.default.currentDirectoryPath
        let path = "./universal/Universalfile"
        let plistURL = URL(fileURLWithPath: path)
        //_ = try String(contentsOfFile: plistURL.path, encoding: .utf8)
        //print(contents)
        
        let data = try Data(contentsOf: plistURL)
        let plistDecoder = PropertyListDecoder()
        let universalfile: Universalfile = try plistDecoder.decode(Universalfile.self, from: data)
        print(universalfile.desc)
        
        if let targets = universalfile.targets {
            archive(with: targets, to: universalfile.output_path)
            createXCFramework(with: universalfile)
        } else {
            exit(with: nil)
        }
    } catch {
        exit(with: error)
    }
}

private func exit(with error: Error?) {
    let errorMessage: String

    if let error = error {
        errorMessage = "\(error.localizedDescription)"
    } else {
        errorMessage = "Error 109"
    }

    print("\(errorMessage)")
    exit(1)
}

/*
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
*/  

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


/*
 <dict>
     <key>output_path</key>
     <string>frameworks</string>
     <key>framework</key>
     <string>xcf</string>
     <key>targets</key>
     <array>
         <dict>
             <key>os</key>
             <string>iOS</string> <!-- iOS | tvOS -->
             <key>workspace</key> <!-- project | workspace -->
             <string>universal-framework.xcworkspace</string>
             <key>scheme</key>
             <string>xcf</string>
         </dict>
     </array>
 </dict>
 </plist>
 */
public class Universalfile: Codable {
    
    // MARK: Properties
    
    /// output_path specifies the directory where any created archives will be placed, or the archive that should be exported. For a successful result .xcframework will be found in this directory.
    let output_path: String
    let framework: String
    let targets: [Target]?

    // MARK: Types
    enum CodingKeys: String, CodingKey {
        case output_path = "output_path"
        case framework = "framework"
        case targets = "targets"
    }
    
    public var desc: String {
        return ("output_path: \(String(output_path)) \n" +
                " framework: \(String(framework)) \n"
                )
    }
}

/// Enums
public enum SDK: String, Codable {
    case iOS
    case iOSSimulator
    case macOS
    case tvOS
    case tvOSSimulator
    case watchOS
    case watchSimulator

    var description: String {
        switch self {
            case .iOS:            return "iphoneos"
            case .iOSSimulator:   return "iphonesimulator"
            case .macOS:          return "macosx"
            case .tvOS:           return "appletvos"
            case .tvOSSimulator:  return "appletvsimulator"
            case .watchOS:        return "watchos"
            case .watchSimulator: return "watchsimulator"
        }
    }
}

public class Target: Codable {

    // MARK: Types
    enum CodingKeys: String, CodingKey {
        case sdk = "sdk"
        case workspace = "workspace"
        case project = "project"
        case scheme = "scheme"
    }
    
    // MARK: Properties
    let sdk: SDK
    let workspace: String?
    let project: String?
    let scheme: String
    
    /// Description
    public var desc: String {
        return ("sdk: \(String(sdk.rawValue)) \n" +
                " workspace: \(String(workspace ?? "-")) \n" +
                " project: \(String(project ?? "-")) \n" +
                " scheme: \(String(scheme)) \n"
                )
    }
}
