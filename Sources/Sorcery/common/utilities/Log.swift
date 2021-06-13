//
//  Log.swift
//  Core
//
//  Created by John Cumming on 2/27/18.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation
import os

/// Logging system backed by Apple's os.Logger API's introduced in iOS 13.
///
/// Logging supports detailed output which includes: level, catergory, file name and line number and debuggers string.
///
/// Examples:
///     `Log.debug()` level: debug
///     `Log.trace()` level: debug
///     `Log.task()` level: .debug
///     `Log.bogus()` level: .debug
///
///     `Log.notice()` level: .info
///     `Log.info()` level: .info
///
///     `Log.warninging()` level: .error
///     `Log.error()` level: .error
///
///     `Log.critical()` level: .fault, will drop into the debugger in a DEBUG build
///     `Log.fault()` level: .fault, will drop into the debugger in a DEBUG build
///
///     `Log.info("Render loop \(seconds)",to: .pref)` level: .fault
///
/// Outputs to console:
///     [timestamp] [app[?:?]] [cagegory] [type:] [message] ➡️ [[filename]:[lineNumber]]
///     `2020-09-04 11:06:25.551557-0700 FireList[85651:1743414] [main] = ✅ TASK: ❤️ ➡️ [AppService.swift:230]`
///
/// Use Xcode's 'File > Open Quickly...' to paste in [filename]:[lineNumber] to revisit code that generated the log entry
///
/// Using Xcode console filter:
///     `=` See only messages that our code logged. This removes all the system logging from the display.
///     `🎱 DEBUG:` View only debug logs enties on any category
///     `[database]` View all logs entries in the datadase category
///
/// Best practice, do not silence any logging category and use the filter in Xcode to focus on issues.
///
/// Second best practice,
///   while developing silence all but the debug category, use .debug() .trace() & .task()
///   in release, do not silence any logging category

public enum Log {

    static let subsystem: String = "com.siliconsorcery.log"
    
    #if DEBUG
        /// Set following lets to control logging for debug run.
        /// Recommend leaving them all as 'false' when checking in.
        static let mainLog = true
        static let refluxLog = true
    
    /// Breaks to the debugged on Log.error, Log.critical & Log.fault
        static let shouldDebug = true
    #else
        static let mainLog = true
        static let refluxLog = true
    
        /// Don't breaks to the on Log.error, Log.critical & Log.fault
        static let shouldFatal = false
    #endif

    
    public enum Category {
        // Required
        case debug // Short lived logging, best not checked in to git.
        case main // Catch-all
        case reflux // Reflux commands and actions
    }

    static let loggingMap: [Category: Logging] = [
        .debug: Logging("debug", silence: false) // Always
        ,.main: Logging("main", silence: !mainLog)
        ,.reflux: Logging("reflux", silence: !refluxLog)
    ]

    struct Logging {
        let logger: Logger
        let silence: Bool // When true, it still reports on OSLogType.error and OSLogType.fault level logging.
        
        init(
            _ category: String = "debug"
            ,silence: Bool
        ) {
            self.logger = Logger(subsystem: subsystem, category: category)
            self.silence = silence
        }
    }
    
    /// Provides direct access to Logger for use with functions that require 'string interpolation'.
    /// This allows for Apple to handle redacting.
    ///
    /// Useage:
    ///     `Log.to(.database).error("User password: \(password)")`
    public static func to(_ category: Category) -> Logger {
        guard let logging = loggingMap[category] else { fatalError() }
        return logging.logger
    }
    
    /// Handle logging to Apple's Logger API
    /// Since the `message` is passed in, it is bypassing Apple's redacting engine and the `message` string is created if dynamic at call time.
    /// Passing the `message` allow for aditional logging feature:
    /// - Filtering
    /// - function, file & line numbers
    /// - Prefixing emoji & type information
    private static func log(
        _ message: String,
        category: Category = .debug,
        level: OSLogType = .default,
        withFileLine: Bool = true,
        funcName: String,
        fileName: String,
        lineNumber: Int
    ) {
        guard let logging = loggingMap[category] else { fatalError() }
        if logging.silence && !(level == .fault || level == .error) { return }
        
        let debug = (level == .debug) ? "=" : ""
        if withFileLine {
            var pathLessFileName = fileName
            if let lastForwardSlash = fileName.range(of: "/", options: .backwards) {
                pathLessFileName = String(fileName.suffix(from: lastForwardSlash.upperBound))
            }
            logging.logger.log(level: level, "~\(debug) \(message) ➡️ \(funcName) [\(pathLessFileName):\(lineNumber)]")
        } else {
            logging.logger.log(level: level, "~\(debug) \(message)")
        }
    }
    /// Logs a note
    ///
    /// - Parameters:
    ///   - message: Text message to log
    ///   - funcName: Defaults to Function Name at compile time
    ///   - fileName: Defaults to File Name at compile time
    ///   - lineNumber: Defaults to Line number in source file at compile time


    public static func debug(
        _ message: String = "",
        to category: Category = .debug,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        log(
            "🎱 DEBUG: \(message)",
            category: category,
            level: .debug,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    public static func trace(
        _ message: String = "",
        to category: Category = .debug,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        log(
            "📡 TRACE: \(message)",
            category: category,
            level: .debug,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }

    public static func task(
        _ message: String = "❤️",
        to category: Category = .debug,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        log(
            "✅ TASK: \(message)",
            category: category,
            level: .debug,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    public static func bogus(
        _ message: String = "❤️",
        to category: Category = .debug,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        log(
            "💩 BOGUS: \(message)",
            category: category,
            level: .debug,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    public static func notice(
        _ message: String = "",
        to category: Category = .main,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        log(
            "🔔 NOTICE: \(message)",
            category: category,
            level: .info,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    public static func info(
        _ message: String = "",
        to category: Category = .main,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        log(
            "🔷 INFO: \(message)",
            category: category,
            level: .info,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }

    public static func warning(
        _ message: String = "",
        to category: Category = .main,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        log(
            "⚠️ WARN: \(message)",
            category: category,
            level: .error,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }

    public static func error(
        _ message: String = "",
        to category: Category = .main,
        debug: Bool = false,
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        log(
            "🛑 ERROR: \(message)",
            category: category,
            level: .error,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
#if DEBUG
        if debug && shouldDebug { raise(SIGINT) }
#endif
    }
    
    public static func critical(
        _ message: String = "",
        to category: Category = .main,
        debug: Bool = true,
        fileName: String = #file,
        funcName: String = #function,
        lineNumber: Int = #line
    ) {
        log(
            "⛔️ CRITICAL: \(message)",
            category: category,
            level: .error,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
#if DEBUG
        if debug && shouldDebug { raise(SIGINT) }
#endif
    }
    
    public static func fault(
        _ message: String = "",
        to category: Category = .main,
        debug: Bool = true,
        fileName: String = #file,
        funcName: String = #function,
        lineNumber: Int = #line
    ) {
        log(
            "📛 FAULT: \(message)",
            category: category,
            level: .error,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
#if DEBUG
        if debug && shouldDebug { raise(SIGINT) }
#endif
    }
    
    public static func echo(
        _ message: String = "",
        funcName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line
    ) {
        log(
            "🎲 - \(message)",
            category: .reflux,
            level: .info,
            withFileLine: false,
            funcName: funcName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
}
