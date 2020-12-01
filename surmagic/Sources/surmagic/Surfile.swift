//
//  Surfile.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 01.12.2020.
//  Copyright © 2020 https://github.com/gurhub/surmagic.
//

import Foundation

/***********************************
<dict>
  <key>output_path</key>
  <string>_OUTPUT_DIRECTORY_NAME_HERE_</string>
  <key>framework</key>
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

**********************************/

/// Check the content of the Surfile.
public class Surfile: Codable {
    
    // MARK: Properties
    
    /// output_path specifies the directory where any created archives will be placed,
    /// or the archive that should be exported.
    /// For a successful result .xcframework will be found in this directory.
    let output_path: String
    let framework: String
    let targets: [Target]?
    
    public var desc: String {
        return ("output_path: \(String(output_path)) \n" +
                " framework: \(String(framework)) \n"
                )
    }
    
    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case output_path = "output_path"
        case framework = "framework"
        case targets = "targets"
    }
}
