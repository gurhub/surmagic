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

/* OLD LOGIC
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
*/

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
        
        print(Colors.green + "\n 🗑 Cleaned output directory.\n" + Colors.reset)
        
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
        remove(directory)
        create(directory)
    }
}

private func archive(with target: Target, to directory: String) {
    var directories = [String]()
    
    let deviceArchivePath = "./\(directory)/\(target.sdk).xcarchive"
    directories.append(deviceArchivePath)
    
    if target.sdk == .iOS {
        let simulatorArchivePath = "./\(directory)/simulator.xcarchive"
        directories.append(simulatorArchivePath)
    }
    
    reset(directories)
    
    // OVER HERE...
}

private func archive(with targets: [Target], to directory: String) {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    
    for target in targets {
        print(target.desc)
        
        var arguments:[String] = [String]()
        arguments.append("xcodebuild")
        arguments.append("archive")
        
        if let workspace = target.workspace {
            arguments.append("-workspace")
            arguments.append(workspace)
        } else if let project = target.project {
            arguments.append("-project \(project)")
            arguments.append(project)
        } else {
            print(Colors.red + "\n ⚠️ Missing parameter for the target. Please re-check the parameters below:\n \(target.desc) \n." + Colors.reset)
            continue
        }
        
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
            
            print(Colors.green + "\n ✅ Completed archiving for \(target.sdk)  \n" + Colors.reset)
            
        } catch { //TODO: write catch for executing command
            exit(with: nil)
        }
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
    case tvOS
    // TODO: Add more...
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
