//
//  Surfile.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 01.12.2020.
//  Copyright © 2021 https://github.com/gurhub/surmagic.
//

import Foundation

/***********************************
 
> as a Plist

 <dict>
     <key>output_path</key>
     <string>_OUTPUT_DIRECTORY_NAME_HERE_</string>
     <key>frameworks</key>
     <array>
        <dict>
            <key>name</key>
            <string>_FRAMEWORK_NAME_HERE_</string>
            <key>targets</key>
            <array>
                <dict>
                    <key>sdk</key>
                    <string>_TARGET_OS_HERE_</string>
                    <key>workspace</key>
                    <string>_WORKSPACE_NAME_HERE_.xcworkspace</string>
                    <key>scheme</key>
                    <string>_SCHEME_NAME_HERE_</string>
                </dict>
            </array>
        </dict>
     </array>
    <key>finalActions</key>
    <array>
        <string>openDirectory</string>
    </array>
 </dict>

 
> as a JSON:
 
 {
     "output_path": "_OUTPUT_DIRECTORY_NAME_HERE_",
     "frameworks": [
        {
            "name": "_FRAMEWORK_NAME_HERE_",
            "targets": [
            {
                "sdk": "_TARGET_OS_HERE_",
                "workspace": "_WORKSPACE_NAME_HERE_.xcworkspace",
                "scheme": "_SCHEME_NAME_HERE_"
            }]
        }
     ],
     "finalActions": ["openDirectory"]
 }

 > as a File form.
 
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
     <dict>
         <key>output_path</key>
         <string>_OUTPUT_DIRECTORY_NAME_HERE_</string>
         <key>frameworks</key>
         <array>
            <dict>
                <key>name</key>
                <string>_FRAMEWORK_NAME_HERE_</string>
                <key>targets</key>
                <array>
                    <dict>
                        <key>sdk</key>
                        <string>_TARGET_OS_HERE_</string>
                        <key>workspace</key>
                        <string>_WORKSPACE_NAME_HERE_.xcworkspace</string>
                        <key>scheme</key>
                        <string>_SCHEME_NAME_HERE_</string>
                    </dict>
                </array>
            </dict>
         </array>
        <key>finalActions</key>
        <array>
            <string>openDirectory</string>
        </array>
     </dict>
 </plist>

**********************************/

/// Content of the Surfile.
public class Surfile: Codable {
    
    // MARK: - Properties
    
    /// output_path specifies the directory where any created archives will be placed,
    /// or the archive that should be exported.
    /// For a successful result .xcframework will be found in this directory.
    let output_path: String
    
    /// Name of the target framework.
    let framework: String?

    /// The array of the target frameworks to create.
    let targets: [Target]?
    
    /// The array of the frameworks to create.
    let frameworks: [Framework]?

    /// Final actions after finishing the work. If it's empty, no action will take by the system.
    ///  - @usage: ["openDirectory", ...etc]
    let finalActions: [FinalAction]?
    
    public var desc: String {
        var result = (
            " output_path: \(String(output_path)) \n"
        )

        if let framework = framework {
            result.append(contentsOf: " framework: " + framework + " \n")
        }
        
        if let targets = targets {
            for item in targets {
                result.append(contentsOf: " target: " + item.desc + " \n")
            }
        }

        if let frameworks = frameworks {
            for item in frameworks {
                result.append(contentsOf: " framework: " + item.desc + " \n")
            }
        }
        
        if let finalActions = finalActions {
            for item in finalActions {
                result.append(contentsOf: " finalAction: " + item.rawValue + " \n")
            }
        }
        
        return result
    }
    
    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case output_path = "output_path"
        case framework = "framework"
        case targets = "targets"
        case frameworks = "frameworks"
        case finalActions = "finalActions"
    }
}
