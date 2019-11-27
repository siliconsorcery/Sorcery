//
//  Store.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation
import SwiftUI
import Combine

final public class Store<S: RefluxState>: ObservableObject {
    @Published public var state: S

    private var dispatchFunction: Dispatch!
    private let apply: Apply<S>
    
    public init(
        state: S,
        middleman: [Middleman<S>] = [],
        apply: @escaping Apply<S>
    ) {
        self.state = state
        self.apply = apply
        
        var middleman = middleman
        middleman.append(asyncActionsMiddleman)
        self.dispatchFunction = middleman
            .reversed()
            .reduce(
                { [unowned self] action in
                    self._dispatch(action: action) },
                { dispatchFunction, middleman in
                    let dispatch: (Action) -> Void = { [weak self] in self?.dispatch(action: $0) }
                    let getState = { [weak self] in self?.state }
                    return middleman(dispatch, getState)(dispatchFunction)
            })
    }

    public func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.dispatchFunction(action)
        }
    }
    
    private func _dispatch(action: Action) {
        state = apply(state, action)
    }
}