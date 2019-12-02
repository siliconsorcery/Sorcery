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

final public class Store<S: RefluxState, C: CoreServices>: ObservableObject {
    
    @Published public var state: S
    public let services: C

    private var dispatchFunction: Dispatch!
    private let apply: Apply
        
    public init(
        state: S,
        middleman: [Middleman<S>] = [],
        services: C
    ) {
        self.state = state
        self.services = services
        
        self.apply = state.apply
        
        var middleman = middleman
        middleman.append(asyncActionsMiddleman)
        self.dispatchFunction = middleman
        .reversed()
        .reduce(
            { [unowned self] action in
                self._dispatch(action: action) },
            { dispatchFunction, middleman in
                let dispatch: (Action) -> Void = { [weak self] in self?.dispatch($0) }
                let getState = { [weak self] in self?.state }
                return middleman(dispatch, getState)(dispatchFunction)
            }
        )
        
    }

    public func dispatch(_ action: Action) {
        DispatchQueue.main.async {
            self.dispatchFunction(action)
        }
    }
    
    private func _dispatch(action: Action) {
        state = apply(action) as! S
    }
}
