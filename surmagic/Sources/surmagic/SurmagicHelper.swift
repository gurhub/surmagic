//
//  SurmagicHelper.swift
//  Surmagic
//
//  Created by Muhammed Gurhan Yerlikaya on 01.12.2020.
//  Copyright © 2021 https://github.com/gurhub/surmagic.
//

import Foundation
import TSCBasic // Colors with Terminal Controller

public class SurmagicHelper {
    
    // MARK: - Properties
    
    /// TerminalController
    private let terminalController = TerminalController(stream: stdoutStream)
    
    /// Singleton
    public static let shared: SurmagicHelper = SurmagicHelper()
    
    // MARK: - Methods
    
    /// Writes a string to the stream via TerminalController.
    /// - Parameters:
    ///   - string: text to write
    ///   - color: color of the text. The default behavior is not coloring the text.
    ///   - bold: makes text bold. The Default is false.
    public func write(_ string: String, inColor color: TerminalController.Color = .noColor, bold: Bool = false) {
        terminalController?.write(string, inColor: color, bold: bold)
    }
    
    /// Writes a string to the stream via TerminalController and inserts a new line character into the stream.
    /// - Parameters:
    ///   - string: text to write
    ///   - color: color of the text. The default behavior is not coloring the text.
    ///   - bold: makes text bold. The Default is false.
    public func writeLine(_ string: String, inColor color: TerminalController.Color = .noColor, bold: Bool = false) {
        write(string, inColor: color, bold: bold)
        endLine()
    }
    
    /// Inserts a new line character into the stream via TerminalController.
    public func endLine() {
        terminalController?.endLine()
    }
}
