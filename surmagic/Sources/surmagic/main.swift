//
//  main.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 29.11.2020.
//  Copyright © 2021 https://github.com/gurhub/surmagic.
//

import ArgumentParser

@available(OSX 11.2, *)
struct Surmagic: ParsableCommand {
    
    /// The Configuration
    static var configuration = CommandConfiguration(
        // Optional abstracts and discussions are used for help output.
        abstract: """
                    🚀 The better way to deal with Binary Frameworks for iOS, Mac Catalyst,
                       tvOS, macOS, and watchOS. Create XCFrameworks with ease for multiple
                       platforms at one shot!
                  """,

        // Commands can define a version for automatic '--version' support.
        version: "1.2.5",
        
        // Subcommands
        subcommands: [`init`.self, xcf.self, env.self],
        
        // A default subcommand, when provided, is automatically selected if a
        // subcommand is not given on the command line.
        defaultSubcommand: xcf.self)
}

@available(OSX 11.2, *)
struct Options: ParsableArguments {
    @Flag(name: [.customLong("verbose"), .customShort("v")],
          help: "'--verbose' flag to help diagnose problems.")
    var verbose = false

}

/// The 'xcf' subcommand. It's the default subcommand.
@available(OSX 11.2, *)
struct xcf: ParsableCommand {
    static var configuration =
                CommandConfiguration(abstract: "Creates an XCFramework via Surfile.")

    // OptionGroup
    @OptionGroup var options: Options

    mutating func run() {
        XCFCommand.shared.createFramework(verbose: options.verbose)
    }    
}

/// 'init' subcommand
@available(OSX 11.2, *)
struct `init`: ParsableCommand {
    static var configuration =
        CommandConfiguration(abstract: "Creates the mandatory directory \(SurmagicConstants.surfileDirectory) and files.")

    @OptionGroup var options: Options

    mutating func run() {
        try! XCFCommand.shared.createTemplateFiles()
    }
}

/// 'env' subcommand
@available(OSX 11.2, *)
struct env: ParsableCommand {
    static var configuration =
                CommandConfiguration(abstract: "To use while creating an issue on Github, prints the user's environment.")

    @OptionGroup var options: Options

    mutating func run() {
        try! ENVCommand.shared.printEnvironment()
    }
}

// Run the surmagic.
if #available(OSX 11.2, *) {
    Surmagic.main()
}
