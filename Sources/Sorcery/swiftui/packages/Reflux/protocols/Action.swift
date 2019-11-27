//
//  Action.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

public protocol Action {
    func apply(to state: RefluxState)
}

public protocol AsyncAction: Action {
    func execute(state: RefluxState?, dispatch: @escaping Dispatch)
}
