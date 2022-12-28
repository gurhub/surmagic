//
//  Framework.swift
//  Surmagic
//
//  Created by FFirX on 2022/12/28.
//  Copyright © 2022 FFirX
//

import Foundation

/// Content of the Surfile.
public class Framework: Codable {
    
    // MARK: - Properties

    /// Name of the target framework.
    let name: String
    
    /// The array of the target frameworks to create.
    let targets: [Target]?

    public init(name: String, targets: [Target]?) {
        self.name = name
        self.targets = targets
    }
    
    public var desc: String {
        var result = (
            " name: \(String(name)) \n"
        )
        
        if let targets = targets {
            for item in targets {
                result.append(contentsOf: " target: " + item.desc + " \n")
            }
        }
        
        return result
    }
    
    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case targets = "targets"
    }
}
