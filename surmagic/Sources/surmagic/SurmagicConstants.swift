//
//  SurmagicConstants.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 25.04.2021.
//  Copyright © 2021 https://github.com/gurhub/surmagic.
//

import Foundation

struct SurmagicConstants {
    static let surfileName                 = "Surfile"
    static let surfileDirectory            = "SM"
    static let executablePath              = "/usr/bin/env"
    static let archiveExtension            = ".xcarchive"
    static let unexpectedErrorMessage      = "caused an unexpected error."
    
    func unexpectedError(_ function: String) -> String {
        return "'\(function)' \(SurmagicConstants.unexpectedErrorMessage)"
    }
}
