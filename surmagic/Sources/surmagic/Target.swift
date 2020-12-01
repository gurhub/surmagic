//
//  Target.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 01.12.2020.
//  Copyright © 2020 https://github.com/gurhub/surmagic.
//

import Foundation

public class Target: Codable {

    // MARK: - Enums

    public enum SDK: String, Codable {
        case iOS
        case iOSSimulator
        case macOS
        case macOSCatalyst
        case tvOS
        case tvOSSimulator
        case watchOS
        case watchSimulator

        var description: String {
            switch self {
                case .iOS:            return "iphoneos"
                case .iOSSimulator:   return "iphonesimulator"
                case .macOS:          return "macosx"
                case .macOSCatalyst:  return "macOSCatalyst"
                case .tvOS:           return "appletvos"
                case .tvOSSimulator:  return "appletvsimulator"
                case .watchOS:        return "watchos"
                case .watchSimulator: return "watchsimulator"
            }
        }
    }

    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case sdk = "sdk"
        case workspace = "workspace"
        case project = "project"
        case scheme = "scheme"
    }
    
    // MARK: - Properties
    
    let sdk: SDK
    let workspace: String?
    let project: String?
    let scheme: String
    
    // MARK: - Description
    public var desc: String {
        return ("sdk: \(String(sdk.rawValue)) \n" +
                " workspace: \(String(workspace ?? "-")) \n" +
                " project: \(String(project ?? "-")) \n" +
                " scheme: \(String(scheme)) \n"
                )
    }
}
