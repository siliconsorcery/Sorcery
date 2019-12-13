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

final public class StoreFlux<S: StoreFluxState, C: StoreFluxServices>: ObservableObject {
            
    public init(
        state: S,
        middleman: [StoreFluxMiddleman<S, C>] = [],
        services: C
    ) {
        self.state = state
        self.services = services
        
        self.apply = state.apply
        
        var middleman = middleman
        middleman.append(kStoreFluxAsyncActionsMiddleman)
        self.dispatchFunction = middleman
        .reversed()
        .reduce(
            { [unowned self] action in
                self._dispatch(action: action)
            },
            { dispatchFunction, middleman in
                let dispatch: (StoreFluxAction) -> Void = { [weak self] in
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
    
    public func dispatch(_ action: StoreFluxAction) {
        DispatchQueue.main.async {
            self.dispatchFunction(action)
        }
    }
    
    // MARK: - Private
    
    private var dispatchFunction: StoreFluxDispatch!
    private let apply: StoreFluxApply

    private func _dispatch(action: StoreFluxAction) {
        state = apply(action) as! S
    }
}

public let kStoreFluxAsyncActionsMiddleman: StoreFluxMiddleman<StoreFluxState, StoreFluxServices> = { dispatch, getState, getServices in
    return { next in
        return { action in
            if let action = action as? StoreFluxAsyncAction {
                action.execute(state: getState(), services: getServices(), dispatch: dispatch)
            }
            return next(action)
        }
    }
}

public typealias StoreFluxApply = (_ action: StoreFluxAction) -> StoreFluxState

public protocol StoreFluxAction: ReflectedStringConvertible {
    func apply(to state: StoreFluxState)
}

public protocol StoreFluxAsyncAction: StoreFluxAction {
    func execute(state: StoreFluxState?, services: StoreFluxServices?, dispatch: @escaping StoreFluxDispatch)
}

public protocol StoreFluxState {
    func apply(_ action: StoreFluxAction) -> StoreFluxState
}

public protocol StoreFluxServices {}

public class StoreMockCoreServices: StoreFluxServices {
    
    public let version = "Mock-AppServices-0.0.1"
    
    public init() {}
}

public typealias StoreFluxDispatch = (StoreFluxAction) -> Void

public typealias StoreFluxMiddleman<S, C> = (@escaping StoreFluxDispatch, @escaping () -> S?, @escaping () -> C?)
    -> (@escaping StoreFluxDispatch) -> StoreFluxDispatch
