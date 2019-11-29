//
//  CommandResponseProtocol.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation

//public typealias Execute = (Command) -> (Response?)
//
//public protocol ExecuteProtocol {
//    // Provides a command-responce callback
//    var execute: ((Command) -> (Response?))? { get set }
//    // The UIViewController is responsible to release the reference by
//    // setting execute = nil in viewDidDisappear()
//}
//
//// MARK: - Command
//
//public class Command {
//    @discardableResult
//    public func run(_ any: Any? = nil) -> Response {
//        return NilResponse()
//    }
//}
//
//public class NilCommand: Command {}
//public class ExitCommand: Command {}
//public class NavigateCommand: Command {}
//
//// MARK: - Response
//
//public class Response {}
//public class NilResponse: Response {}
//public class CompletedResponse: Response {}
//public class InCompletedResponse: Response {}
//public class DismissResponse: Response {}
