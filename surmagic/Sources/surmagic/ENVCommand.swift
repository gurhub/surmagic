//
//  ENVCommand.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 14.12.2020.
//  Copyright © 2021 https://github.com/gurhub/surmagic.
//

import Foundation

@available(OSX 11.2, *)
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
            SurmagicHelper.shared.writeLine(SurmagicConstants.unexpectedError,
                                            inColor: .red, bold: false)
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
            SurmagicHelper.shared.writeLine(SurmagicConstants.unexpectedError,
                                            inColor: .red, bold: false)
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
            SurmagicHelper.shared.writeLine(SurmagicConstants.unexpectedError,
                                            inColor: .red, bold: false)
            throw ENVCommandError.EXIT_FAILURE
        }
    }
}
