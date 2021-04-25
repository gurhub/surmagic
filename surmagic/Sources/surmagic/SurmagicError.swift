//
//  SurmagicError.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 25.04.2021.
//  Copyright © 2021 https://github.com/gurhub/surmagic.
//

import Foundation

struct RuntimeError: Error, CustomStringConvertible {
    var description: String
    
    init(_ description: String) {
        self.description = description
    }
}

@available(OSX 11.2, *)
extension XCFCommand {
    public enum XCFCommandError: Error {
        case EXIT_FAILURE
    }
}

@available(OSX 11.2, *)
extension ENVCommand {
    public enum ENVCommandError: Error {
        case EXIT_FAILURE
    }
}
