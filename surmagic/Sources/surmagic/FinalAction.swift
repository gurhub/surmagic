//
//  FinalAction.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 6.02.2022.
//  Copyright © 2022 https://github.com/gurhub/surmagic.
//

import Foundation

public enum FinalAction: String, Codable {
    case openDirectory     /// Opens the target directory.
    
    var description: String {
        switch self {
        case .openDirectory:     return "openDirectory"
        }
    }
}
