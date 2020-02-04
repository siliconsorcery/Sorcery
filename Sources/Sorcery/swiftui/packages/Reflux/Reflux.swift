//
//  Reflux.swift
//  Sorcery
//
//  Created by John Cumming on 1/7/20.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//
// See: README.md

import Foundation
import SwiftUI
import Combine

final public class Reflux<S: Store, C: Service>: ObservableObject {
            
    public init(
        store: S,
        middleware: [Middleware<S, C>] = [],
        service: C
    ) {
        self.store = store
        self.service = service
        
        self.reducer = store.reducer
        
        var middleware = middleware
        middleware.append(kAsyncActionsMiddleware)
        self.dispatchFunction = middleware
        .reversed()
        .reduce(
            { [unowned self] action in
                if let action = action as? Action {
                    self._dispatch(action: action)
                }
            },
            { dispatchFunction, middleware in
                let dispatch: (RefluxAction) -> Void = { [weak self] in
                    self?.dispatch($0)
                }

                let getStore = { [weak self] in
                    self?.store
                }
                
                let getService = { [weak self] in
                    self?.service
                }
                return middleware(dispatch, getStore, getService)(dispatchFunction)
            }
        )
    }
    
    @Published public var store: S
    public let service: C
    
    public func dispatch(_ action: RefluxAction) {
        DispatchQueue.main.async {
            self.dispatchFunction(action)
        }
    }
    
    // MARK: - Private
    
    private var dispatchFunction: Dispatch!
    private let reducer: Reducer

    private func _dispatch(action: Action) {
        store = reducer(action) as! S
    }
}

public protocol Store {
    func reducer(_ action: Action) -> Store
}

public protocol Service {}

public let kAsyncActionsMiddleware: Middleware<Store, Service> = { dispatch, getStore, getService in
    return { next in
        return { action in
            if let action = action as? Async {
                action.apply(store: getStore(), service: getService(), dispatch: dispatch)
            }
            return next(action)
        }
    }
}

public typealias Reducer = (_ action: Action) -> Store

public protocol RefluxAction: ReflectedStringConvertible {
}

public protocol Action: RefluxAction {
    func apply(to store: Store)
}

public protocol Async: RefluxAction {
    func apply(store: Store?, service: Service?, dispatch: @escaping Dispatch)
}

public typealias Dispatch = (RefluxAction) -> Void

public typealias Middleware<S, C> = (@escaping Dispatch, @escaping () -> S?, @escaping () -> C?)
    -> (@escaping Dispatch) -> Dispatch

//

public class MockService: Service {
    
    public let version = "Mock-Service-0.0.1"
    
    public init() {}
}
