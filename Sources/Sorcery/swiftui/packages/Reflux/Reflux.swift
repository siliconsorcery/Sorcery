//
//  File.swift
//  
//
//  Created by John Cumming on 1/7/20.
//

import Foundation
import SwiftUI
import Combine

final public class Reflux<S: Store, C: Service>: ObservableObject {
            
    public init(
        store: S,
        middleman: [Middleman<S, C>] = [],
        service: C
    ) {
        self.store = store
        self.service = service
        
        self.apply = store.apply
        
        var middleman = middleman
        middleman.append(kAsyncActionsMiddleman)
        self.dispatchFunction = middleman
        .reversed()
        .reduce(
            { [unowned self] action in
                if let action = action as? Action {
                    self._dispatch(action: action)
                }
            },
            { dispatchFunction, middleman in
                let dispatch: (RefluxAction) -> Void = { [weak self] in
                    self?.dispatch($0)
                }

                let getStore = { [weak self] in
                    self?.store
                }
                
                let getService = { [weak self] in
                    self?.service
                }
                return middleman(dispatch, getStore, getService)(dispatchFunction)
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
    private let apply: Apply

    private func _dispatch(action: Action) {
        store = apply(action) as! S
    }
}

public protocol Store {
    func apply(_ action: Action) -> Store
}

public protocol Service {}

public let kAsyncActionsMiddleman: Middleman<Store, Service> = { dispatch, getStore, getService in
    return { next in
        return { action in
            if let action = action as? Async {
                action.apply(store: getStore(), service: getService(), dispatch: dispatch)
            }
            return next(action)
        }
    }
}

public typealias Apply = (_ action: Action) -> Store

public protocol RefluxAction: ReflectedStringConvertible {
}

public protocol Action: RefluxAction {
    func apply(to store: Store)
}

public protocol Async: RefluxAction {
    func apply(store: Store?, service: Service?, dispatch: @escaping Dispatch)
}

public typealias Dispatch = (RefluxAction) -> Void

public typealias Middleman<S, C> = (@escaping Dispatch, @escaping () -> S?, @escaping () -> C?)
    -> (@escaping Dispatch) -> Dispatch

//

public class MockService: Service {
    
    public let version = "Mock-Service-0.0.1"
    
    public init() {}
}
