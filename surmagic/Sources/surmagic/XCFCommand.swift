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
    
    // MARK: - Methods
    
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
}

// MARK: - Enums

@available(OSX 10.13, *)
extension XCFCommand {
    public enum SurmagicError: Error {
        case EXIT_FAILURE
    }
}

