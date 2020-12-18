//
//  ENVCommand.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 14.12.2020.
//  Copyright © 2020 https://github.com/gurhub/surmagic.
//

import Foundation

@available(OSX 10.13, *)
public class ENVCommand {
    
    // MARK: - Properties
    
    /// Singleton
    public static let shared: ENVCommand = ENVCommand()
    
    // MARK: - File Methods
    
    /// Creates template files.
    public func printEnvironment() throws {
        try! printSurmagicVersion()
        try! printXcodeVersion()
        try! printSoftwareVersion()
    }
    
    private func printSurmagicVersion() throws {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        task.arguments = ["surmagic", "--version"]
        
        do {
            var message = "\n ℹ️  Printing the information: \n"
            SurmagicHelper.shared.writeLine(message, inColor: .white, bold: true)
            
            message = "\n --------------------------- \n"
            SurmagicHelper.shared.writeLine(message, inColor: .white, bold: true)
            
            try task.run()
            task.waitUntilExit()
            
            message = "\n --------------------------- \n"
            SurmagicHelper.shared.writeLine(message, inColor: .white, bold: true)
        } catch {
            throw ENVCommandError.EXIT_FAILURE
        }
    }
    
    private func printSoftwareVersion() throws {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        task.arguments = ["sw_vers"]
        
        do {
            try task.run()
            task.waitUntilExit()

            let message = "\n --------------------------- \n"
            SurmagicHelper.shared.writeLine(message, inColor: .white, bold: true)
        } catch {
            throw ENVCommandError.EXIT_FAILURE
        }
    }
    
    private func printXcodeVersion() throws {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        
        task.arguments = ["xcodebuild", "-version"]
        
        do {
            try task.run()
            task.waitUntilExit()

            let message = "\n --------------------------- \n"
            SurmagicHelper.shared.writeLine(message, inColor: .white, bold: true)
        } catch {
            throw ENVCommandError.EXIT_FAILURE
        }
    }
}

// MARK: - Enums

@available(OSX 10.13, *)
extension ENVCommand {
    public enum ENVCommandError: Error {
        case EXIT_FAILURE
    }
}
