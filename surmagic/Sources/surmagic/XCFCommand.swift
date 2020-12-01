//
//  XCFCommand.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 01.12.2020.
//  Copyright © 2020 https://github.com/gurhub/surmagic.
//

import Foundation

@available(OSX 10.13, *)
public class XCFCommand {
    
    // MARK: - Properties
    
    /// Singleton
    public static let shared: XCFCommand = XCFCommand()
    
    // MARK: - File Methods
    
    /// Creates template files.
    public func createTemplateFiles() throws {
        
        try! create("./Surmagic")

        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        
        guard let source = Bundle.module.url(forResource: "Surfile",
                                           withExtension: "") else {
            print("No Surfile in the directory.")
            fatalError()
        }
        
        task.arguments = ["cp", "-i", source.path, "./Surmagic/."]
        
        do {
            try task.run()
            task.waitUntilExit()

            let message = "\n 🚚 Initialized default files in the directory.\n"
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)
        } catch {
            throw SurmagicError.EXIT_FAILURE
        }
    }
    
    /// Creates a directory in giving directory.
    private func create(_ directory: String) throws {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        task.arguments = ["mkdir", directory]
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let message = "\n 📂 Created a directory: \(directory) \n"
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)
        } catch {
            throw SurmagicError.EXIT_FAILURE
        }
    }
    
    /// Removes files in giving directory.
    private func remove(_ directory: String) throws {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        task.arguments = ["rm", "-rf", directory]
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let message = "\n 🗑  Removed the directory: \(directory) \n"
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)
        } catch {
            exit(0)
        }
    }
    
    /// Opens the output directory
    /// - Parameter directory: the directory to open.
    private func openOutputPath(_ directory: String) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
         
        /// -archive
        var arguments:[String] = [String]()
        arguments.append("open")
        arguments.append(directory)
        
        task.arguments = arguments

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
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
    
    // MARK: - Main Logic
    
    /// Parse the Surfile (plist) file for the parameters.
    private func mainLogic() {
        do {
            let path = "./Surmagic/Surfile"
            let plistURL = URL(fileURLWithPath: path)
            
            let data = try Data(contentsOf: plistURL)
            let plistDecoder = PropertyListDecoder()
            let surfile: Surfile = try plistDecoder.decode(Surfile.self, from: data)
            
            // Reset the output directory
            let outputPath = "./\(surfile.output_path)"
            reset([outputPath])

            if let targets = surfile.targets {
                // 1 - archive(with: targets, to: surfile.output_path, options: options)
                // 2 - createXCFramework(with: surfile)
            } else {
                exit(0)
            }
        } catch {
            exit(0)
        }
    }
    
    // MARK: - XCFramework Methods
    
    private func createXCFramework(with surfile: Surfile) {
        guard let targets = surfile.targets else { return }

        let directory = surfile.output_path
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
         
        /// -archive
        var arguments:[String] = [String]()
        arguments.append("xcodebuild")
        arguments.append("-create-xcframework")
        
        /// -framework
        for target in targets {
            let archivePath = "./\(directory)/\(target.sdk).xcarchive"
            let path = archivePath + "/Products/Library/Frameworks/\(surfile.framework).framework"
            arguments.append("-framework")
            arguments.append(path)
        }
        
        // Output
        let output = "./\(directory)/\(surfile.framework).xcframework"
        arguments.append("-output")
        arguments.append(output)
        
        task.arguments = arguments

        var message = "\n 🏗  Creating a XCFramework.\n"
        SurmagicHelper.shared.writeLine(message, inColor: .cyan, bold: false)
        
        message = " 📝 : \n \(arguments))"
        SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)

        do {
            try task.run()
            task.waitUntilExit()
            
            message = "\n 🥳 Successfully created a XCFramework on the location: \(output)\n"
            SurmagicHelper.shared.writeLine(message, inColor: .green, bold: false)

            /// clear archive paths
            for target in targets {
                let archivePath = "./\(directory)/\(target.sdk).xcarchive"
                try! remove(archivePath)
            }

            // Finaly open the output path
            openOutputPath(directory)
        } catch {
            exit(0)
        }
    }
}

// MARK: - Enums

@available(OSX 10.13, *)
extension XCFCommand {
    public enum SurmagicError: Error {
        case EXIT_FAILURE
    }
}

