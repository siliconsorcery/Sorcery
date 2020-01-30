//
//  Log.swift
//  Core
//
//  Created by John Cumming on 2/27/18.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation
import UIKit

/// Develop time helper for Logging messages to the console.
//
// Exampled:
//      Log.info("Database initialised.")
//
// Outputs to console:
// 3:59:58.895 🔷 INFO: Database initialised. ➡️ in startUp(key:) [DatabaseServer.swift:42]
// [timestamp] [icon] [type]: [message] ➡️ in [function() signature] [[filename]:[lineNumber]]
//
// Use Xcode's 'File > Open Quickly...' to past in [filename]:[lineNumber] to revisit

public enum Log {

    public enum Output {
        case echo
        case console
        case server
        case serverAndConsole
    }

    private static func event(
        _ message: String,
        to output: Output? = .console,
        funcName: String,
        fileName: String,
        lineNumber: Int
    ) {
        var pathLessFileName = fileName
        if let lastForwardSlash = fileName.range(of: "/", options: .backwards) {
            pathLessFileName = String(fileName.suffix(from: lastForwardSlash.upperBound))
        }
        let dateString = Date().toString(formattedBy: "h:mm:ss.SSS")

        if (output == .server || output == .serverAndConsole) {
            let deviceId = UIDevice.current.identifierForVendor?.uuidString
            let userId = "Unknown"
            let outputMessage = "\(dateString) \(userId) \(message) ➡️ in \(funcName) [\(pathLessFileName):\(lineNumber)] \(deviceId ?? "No Device")"
            // TODO: Add server logging
//            print(outputMessage)
        }
        
        if (output == .console || output == .serverAndConsole) {
            let outputMessage = "\(dateString) \(message) ➡️ in \(funcName) [\(pathLessFileName):\(lineNumber)] "
            print(outputMessage)
        }
        
        if (output == .echo) {
            let outputMessage = "\(dateString) \(message)"
            print(outputMessage)
        }
    }

    /// Logs a note
    ///
    /// - Parameters:
    ///   - message: Text message to log
    ///   - output: Where to log, Defaults to .console
    ///   - funcName: Defaults to Funcation Name at compile time
    ///   - fileName: Defaults to File Name at compile time
    ///   - lineNumber: Defaults to Line number in source file at compile time
    public static func note(
        _ message: String = "❤️",
        to output: Output? = .console,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        event(
            "🔔 NOTE: \(message)",
            to: output,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }

    /**
     Logs a task
     
     - parameters:
     - message: An incomplete/unstarted task. Suggested formatting: “Class.method() - Message”
     - to?: Output channel. Defaults to .console only
     
     */
    public static func task(
        _ message: String = "❤️",
        to output: Output? = .console,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        event(
            "✅ TASK: \(message)",
            to: output,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }

    /**
     Logs a info
     
     - parameters:
     - message: General information. Useful during development. Could be removed/replaced with asserts and guards. Suggested formatting: “Class.method() - Message”
     - to: Output channel. Defaults to .console only
     
     */
    public static func info(
        _ message: String = "",
        to output: Output? = .console,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        event(
            "🔷 INFO: \(message)",
            to: output,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }

    /**
     Logs a warn
     
     - parameters:
     - message: Unexpected yet not fatal!. Needs to be fixed. Suggested formatting: “Class.method() - Message”
     - to: Output channel. Defaults to .serverAndConsole
     
     */
    public static func warn(
        _ message: String = "",
        to output: Output? = .serverAndConsole,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        event(
            "⚠️ WARN: \(message)",
            to: output,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }

    /**
     Logs an error
     
     - parameters:
     - message: Superbad. Needs fixing ASAP. Suggested formatting: “Class.method() - Message”
     - to: Output channel. Defaults to .serverAndConsole
     
     */
    public static func error(
        _ message: String = "",
        to output: Output? = .serverAndConsole,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        event(
            "⛔️ ERROR: \(message)",
            to: output,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )

        Alert.show(title: "Sorry!", message: "\(message)")
    }
    
    public static func echo(
        _ message: String = "",
        to output: Output? = .echo,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        event(
            "🎲 - \(message)",
            to: output,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }

}
