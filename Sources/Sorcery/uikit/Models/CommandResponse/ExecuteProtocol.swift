//
//  CommandResponseProtocol.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation

public typealias Execute = (Command) -> (Response?)

public protocol ExecuteProtocol {
    // Provides a command-responce callback
    var execute: ((Command) -> (Response?))? { get set }
    // The UIViewController is responsible to release the reference by
    // setting execute = nil in viewDidDisappear()
}

// MARK: - Command

open class Command {
    @discardableResult
    open func run(_ any: Any? = nil) -> Response {
        return NilResponse()
    }
}

open class NilCommand: Command {}
open class ExitCommand: Command {}
open class NavigateCommand: Command {}

// MARK: - Response

open class Response {
    public init() {}
}
open class NilResponse: Response {}
open class CompletedResponse: Response {}
open class InCompletedResponse: Response {}
open class DismissResponse: Response {}
