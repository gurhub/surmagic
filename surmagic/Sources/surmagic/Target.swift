//
//  Target.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 01.12.2020.
//  Copyright © 2021 https://github.com/gurhub/surmagic.
//

import Foundation

public class Target: Codable {
    
    // MARK: - Enums
    
    /// SDK type names changes per OS.
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

        var destination: String {
            switch self {
            case .iOS:            return "generic/platform=iOS"
            case .iOSSimulator:   return "generic/platform=iOS Simulator"
            case .macOS:          return "generic/platform=macOS"
            case .macOSCatalyst:  return "generic/platform=macOS,variant=Mac Catalyst"
            case .tvOS:           return "generic/platform=tvOS"
            case .tvOSSimulator:  return "generic/platform=tvOS Simulator"
            case .watchOS:        return "generic/platform=watchOS"
            case .watchSimulator: return "generic/platform=watchOS Simulator"
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
        return (
            "sdk: \(String(sdk.rawValue)) \n" +
            " workspace: \(String(workspace ?? "-")) \n" +
            " project: \(String(project ?? "-")) \n" +
            " scheme: \(String(scheme)) \n"
        )
    }
}
