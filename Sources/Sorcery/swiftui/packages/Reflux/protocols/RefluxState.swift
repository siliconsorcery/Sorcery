//
//  RefluxState.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

public protocol RefluxState {
    func apply(_ action: Action) -> RefluxState
}
