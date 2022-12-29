//
//  XCFCommand.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 01.12.2020.
//  Copyright © 2021 https://github.com/gurhub/surmagic.
//

import Foundation

@available(OSX 11.2, *)
public class XCFCommand {
    
    // MARK: - Properties
    
    /// Singleton
    public static let shared: XCFCommand = XCFCommand()
    
    // MARK: - File Methods
    
    /// Creates template files.
    public func createTemplateFiles() throws {
        // 1 - Create directory
        try create("./\(SurmagicConstants.surfileDirectory)")

        /// 2 - Create an empty Surfile under "/Surmagic/Surfile"
        try createEmptyFile(SurmagicConstants.surfileName)
        
        /// 3 - Write a template content in the Surfile
        let content = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
            <dict>
                <key>output_path</key>
                <string>_OUTPUT_DIRECTORY_NAME_HERE_</string>
                <key>frameworks</key>
                <array>
                    <dict>
                        <key>name</key>
                        <string>_FRAMEWORK_NAME_HERE_</string>
                        <key>targets</key>
                        <array>
                            <dict>
                                <key>sdk</key>
                                <string>\(Target.SDK.iOS.rawValue)</string>
                                <key>workspace</key>
                                <string>_WORKSPACE_NAME_HERE_.xcworkspace</string>
                                <key>scheme</key>
                                <string>_SCHEME_NAME_HERE_</string>
                            </dict>
                            <dict>
                                <key>sdk</key>
                                <string>\(Target.SDK.iOSSimulator.rawValue)</string>
                                <key>workspace</key>
                                <string>_WORKSPACE_NAME_HERE_.xcworkspace</string>
                                <key>scheme</key>
                                <string>_SCHEME_NAME_HERE_</string>
                            </dict>
                            <!--
                                Remove this comment and add more targets for Simulators and the Devices.
                            -->
                        </array>
                    </dict>
                    <!--
                        Remove this comment and add more frameworks.
                    -->
                </array>
                <key>finalActions</key>
                <array>
                    <string>openDirectory</string>
                </array>
            </dict>
        </plist>
        """
        
        let file = "./\(SurmagicConstants.surfileDirectory)/\(SurmagicConstants.surfileName)"
        
        guard let _ = try? content.write(toFile: file,
                                         atomically: true,
                                         encoding: .utf8) else {
            throw RuntimeError("Couldn't write to file '\(SurmagicConstants.surfileDirectory)'!")
        }
        
        // Finaly open the template file directory.
        openOutputPath(file)
    }
    
    /// Creates an empty file with giving @name under the "SM" directory.
    public func createEmptyFile(_ name: String) throws {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: SurmagicConstants.executablePath)
        
        task.arguments = ["touch", "./\(SurmagicConstants.surfileDirectory)/\(name)"]
        
        do {
            try task.run()
            task.waitUntilExit()

            let message = "\n 📃 Created an empty Surfile.\n"
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)
        } catch {
            SurmagicHelper.shared.writeLine(SurmagicConstants().unexpectedError(#function),
                                            inColor: .red, bold: false)
            throw XCFCommandError.EXIT_FAILURE
        }
    }
    
    /// Creates a directory in giving directory.
    private func create(_ directory: String) throws {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: SurmagicConstants.executablePath)
        task.arguments = ["mkdir", directory]
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let message = "\n 📂 Created a directory: \(directory) \n"
            SurmagicHelper.shared.writeLine(message, inColor: .yellow, bold: false)
        } catch {
            SurmagicHelper.shared.writeLine(SurmagicConstants().unexpectedError(#function),
                                            inColor: .red, bold: false)
            throw XCFCommandError.EXIT_FAILURE
        }
    }
    
    /// Removes files in giving directory.
    private func remove(_ directory: String) throws {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: SurmagicConstants.executablePath)
        task.arguments = ["rm", "-rf", directory]
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let message = "\n 🗑  Removed the directory: \(directory) \n"
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)
        } catch {
            SurmagicHelper.shared.writeLine(SurmagicConstants().unexpectedError(#function),
                                            inColor: .red, bold: false)
            
            exit(0)
        }
    }
    
    /// Runs final actions if any available.
    private func runFinalActions(_ surfile: Surfile) {
        if let finalActions = surfile.finalActions {
            for action in finalActions {
                let message = "\n ⚪️ Action: \(action)\n"
                SurmagicHelper.shared.writeLine(message, inColor: .cyan, bold: false)
                
                switch action {
                case .openDirectory:
                    openOutputPath(surfile.output_path)
                }
            }
        } else {
            let message = "\n 🏁 No Final Actions to run\n"
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)
        }
    }
    
    /// Opens the output directory
    /// - Parameter directory: the directory to open.
    private func openOutputPath(_ path: String) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: SurmagicConstants.executablePath)
         
        var arguments:[String] = [String]()
        arguments.append("open")
        arguments.append(path)
        
        task.arguments = arguments

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            SurmagicHelper.shared.writeLine(SurmagicConstants().unexpectedError(#function),
                                            inColor: .red, bold: false)
            
            exit(0)
        }
    }

    /// Resets directories
    /// - Parameter directories: array of directories
    private func reset(_ directories: [String]) {
        for directory in directories {
            try! remove(directory)
            try! create(directory)
        }
    }
    
    // MARK: - XCFramework Methods
        
    /// Parse the Surfile (plist) file for the parameters.
    public func createFramework(verbose: Bool) {
        do {
            let path = "./\(SurmagicConstants.surfileDirectory)/\(SurmagicConstants.surfileName)"
            let plistURL = URL(fileURLWithPath: path)
            
            let data = try Data(contentsOf: plistURL)
            let plistDecoder = PropertyListDecoder()
            let surfile: Surfile = try plistDecoder.decode(Surfile.self, from: data)
            
            // Reset the output directory
            let outputPath = "./\(surfile.output_path)"
            reset([outputPath])

            createFramework(with: surfile, verbose: verbose)
        } catch {
            SurmagicHelper.shared.writeLine(SurmagicConstants().unexpectedError(#function),
                                            inColor: .red, bold: false)
            
            exit(0)
        }
    }
    
    /// Create frameworks with the parameters from the Surfile (plist) file.
    private func createFramework(with surfile: Surfile, verbose: Bool) {
        var frameworks: [Framework] = []

        if let fwName = surfile.framework {
            let fw = Framework(name: fwName, targets: surfile.targets)
            frameworks.append(fw)
        }
        if let fws = surfile.frameworks {
            frameworks.append(contentsOf: fws)
        }

        if frameworks.count == 0 {
            let message = "\(SurmagicConstants().unexpectedError(#function)). No framework to create"
            SurmagicHelper.shared.writeLine(message, inColor: .red, bold: false)

            exit(0)
        }

        let directory = surfile.output_path

        for framework in frameworks {
            let name = framework.name

            if let targets = framework.targets {
                archive(with: targets, to: directory, verbose: verbose)
                createXCFramework(with: name, and: targets, to: directory)
            } else {
                let message = "\(SurmagicConstants().unexpectedError(#function)). Missing targets for \(name)"
                SurmagicHelper.shared.writeLine(message, inColor: .red, bold: false)
                
                exit(0)
            }
        }

        let message = "\n ✅ Create completed \(frameworks.count > 1 ? "for all frameworks" : "the framework")."
        SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)

        // Run final actions before completing.
        runFinalActions(surfile)
    }
    
    // MARK: - XCFramework Methods

    private func createXCFramework(with name: String, and targets: [Target], to directory: String) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: SurmagicConstants.executablePath)
         
        /// -archive
        var arguments:[String] = [String]()
        arguments.append("xcodebuild")
        arguments.append("-create-xcframework")
        
        /// -framework
        for target in targets {
            let archivePath = "./\(directory)/\(target.sdk)\(SurmagicConstants.archiveExtension)"
            let path = archivePath + "/Products/Library/Frameworks/\(name).framework"
            arguments.append("-framework")
            arguments.append(path)
        }
        
        // Output
        let output = "./\(directory)/\(name).xcframework"
        arguments.append("-output")
        arguments.append(output)
        
        task.arguments = arguments

        var message = "\n 🏗  Creating the XCFramework.\n"
        SurmagicHelper.shared.writeLine(message, inColor: .cyan, bold: false)
        
        message = " 📝 : \n \(arguments))"
        SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)

        do {
            try task.run()
            task.waitUntilExit()
            
            /// clear archive paths
            for target in targets {
                let archivePath = "./\(directory)/\(target.sdk)\(SurmagicConstants.archiveExtension)"
                try! remove(archivePath)
            }
            
            message = "\n 🥳 Successfully created a XCFramework on the location: \(output)\n"
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)

        } catch {
            exit(0)
        }
    }
    
    //MARK: - Build Methods
    
    private func archive(with target: Target, to directory: String, verbose: Bool) {
        var message = ""
        let task = Process()
        task.executableURL = URL(fileURLWithPath: SurmagicConstants.executablePath)
        
        let archivePath = "./\(directory)/\(target.sdk)\(SurmagicConstants.archiveExtension)"
        
        /// reset directories
        reset([archivePath])
        
        /// archive
        var arguments:[String] = [String]()
        arguments.append("xcodebuild")

        if !verbose {
            arguments.append("-quiet")
        }
     
        arguments.append("archive")
        
        if let workspace = target.workspace {
            arguments.append("-workspace")
            arguments.append(workspace)
        } else if let project = target.project {
            arguments.append("-project")
            arguments.append(project)
        } else {
            message = "\n ⚠️ Missing parameter for the target. Please re-check the parameters below:\n \(target.desc)"
            SurmagicHelper.shared.writeLine(message, inColor: .red, bold: false)
            return
        }
        
        arguments.append("-sdk")

        if target.sdk == .macOSCatalyst {
            arguments.append(Target.SDK.macOS.description)
        } else {
            arguments.append(target.sdk.description)
        }
        
        arguments.append("-scheme")
        arguments.append(target.scheme)
        
        arguments.append("-destination")
        arguments.append(target.sdk.destination)
        
        arguments.append("-archivePath")
        arguments.append(archivePath)

        arguments.append("SKIP_INSTALL=NO")
        arguments.append("BUILD_LIBRARY_FOR_DISTRIBUTION=YES")

        if target.sdk == .macOSCatalyst {
            arguments.append("SUPPORTS_MACCATALYST=YES")
        }

        task.arguments = arguments
        
        message = "\n 📦 Archiving for the \(target.sdk) SDK.) \n"
        SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)
        
        message = " 📝 : \n \(arguments))"
        SurmagicHelper.shared.writeLine(message, inColor: .cyan, bold: false)
        
        do {
            try task.run()
            task.waitUntilExit()
            
            message = "\n 🎯 Archiving completed for the target: \(target.sdk) \n"
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)
            
        } catch {
            exit(0)
        }
    }

    private func archive(with targets: [Target], to directory: String, verbose: Bool) {
        for target in targets {
            archive(with: target, to: directory, verbose: verbose)
        }

        if targets.count > 0 {
            let message = "\n ✅ Archive completed \(targets.count > 1 ? "for all targets" : "the target")."
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)
        }
    }
}
