//
//  main.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 29.11.2020.
//  Copyright © 2020 https://github.com/gurhub/surmagic.
//

import ArgumentParser
import TSCBasic // Colors with Terminal Controller

@available(OSX 10.13, *)
struct Surmagic: ParsableCommand {
    
    /// The Configuration
    static var configuration = CommandConfiguration(
        // Optional abstracts and discussions are used for help output.
        abstract: "🚀 The better way to deal with Binary Frameworks on iOS," +
                  " Mac Catalyst, tvOS, macOS, and watchOS." +
                  "Create XCFrameworks with ease.",

        // Commands can define a version for automatic '--version' support.
        version: "1.2.0",
        
        // Subcommands
        subcommands: [`init`.self, xcf.self],
        
        // A default subcommand, when provided, is automatically selected if a
        // subcommand is not given on the command line.
        defaultSubcommand: xcf.self)
}

@available(OSX 10.13, *)
struct Options: ParsableArguments {
    @Flag(name: [.customLong("verbose"), .customShort("v")],
          help: "'--verbose' flag to help diagnose problems.")
    var verbose = false

}

/// The default subcommand
@available(OSX 10.13, *)
struct xcf: ParsableCommand {
    static var configuration =
                CommandConfiguration(abstract: "Creates an XCFramework via Surfile.")

    // OptionGroup
    @OptionGroup var options: Options

    mutating func run() {
        print("You used: 'xcf' with verbose mode \(options.verbose ? "on" : "off")")
        
        // mainLogic(options: Options)
    }    
}

/// The default subcommand
@available(OSX 10.13, *)
struct `init`: ParsableCommand {
    static var configuration =
                CommandConfiguration(abstract: "Creates the mandatory directory (surmagic) and files.")

    @OptionGroup var options: Options

    mutating func run() {
        try! XCFCommand.shared.createTemplateFiles()
    }
}

// Run the surmagic.
if #available(OSX 10.13, *) {
    Surmagic.main()
}
