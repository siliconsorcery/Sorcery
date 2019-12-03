//
//  StoreFlux.swift
//  Reflux
//
//  Created by John Cumming on 12/2/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation
import SwiftUI
import Combine

final public class StoreFlux<S: RefluxState, C: RefluxServices>: ObservableObject {
            
    public init(
        state: S,
        middleman: [Middleman<S, C>] = [],
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
                self._dispatch(action: action)
            },
            { dispatchFunction, middleman in
                let dispatch: (Action) -> Void = { [weak self] in
                    self?.dispatch($0)
                }

                let getState = { [weak self] in
                    self?.state
                }
                
                let getServices = { [weak self] in
                    self?.services
                }
                return middleman(dispatch, getState, getServices)(dispatchFunction)
            }
        )
    }
    
    @Published public var state: S
    public let services: C
    
    public func dispatch(_ action: Action) {
        DispatchQueue.main.async {
            self.dispatchFunction(action)
        }
    }
    
    // MARK: - Private
    
    private var dispatchFunction: Dispatch!
    private let apply: Apply

    private func _dispatch(action: Action) {
        state = apply(action) as! S
    }
    
    private let asyncActionsMiddleman: Middleman<RefluxState, RefluxServices> = { dispatch, getState, getServices in
        return { next in
            return { action in
                if let action = action as? AsyncAction {
                    action.execute(state: getState(), services: getServices(), dispatch: dispatch)
                }
                return next(action)
            }
        }
    }
}

public typealias StoreFluxDispatch = (Action) -> Void

public typealias StoreFluxMiddleman<S, C> = (@escaping StoreFluxDispatch, @escaping () -> S?, @escaping () -> C?)
    -> (@escaping StoreFluxDispatch) -> StoreFluxDispatch
