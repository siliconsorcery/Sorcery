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
    public init() {}
    @discardableResult
    open func run(_ any: Any? = nil) -> Response {
        return NilResponse()
    }
}

open class NilCommand: Command {
    public override init() {}
}

//open class ExitCommand: Command {
//    public override init() {}
//}
//
//open class NavigateCommand: Command {
//    public override init() {}
//}

// MARK: - Response

open class Response {
    public init() {}
}

open class NilResponse: Response {
    public override init() {}
}
//
//open class CompletedResponse: Response {
//    public override init() {}
//}
//
//open class InCompletedResponse: Response {
//    public override init() {}
//}
//
//open class DismissResponse: Response {
//    public override init() {}
//}
