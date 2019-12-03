//
//  Action.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

public protocol RefluxAction: ReflectedStringConvertible {}

public protocol Action: RefluxAction {
    func apply(to state: RefluxState)
}

public protocol AsyncAction: Action {
//    func execute(
    func execute(state: RefluxState?, services: RefluxServices?, dispatch: @escaping Dispatch)
}
