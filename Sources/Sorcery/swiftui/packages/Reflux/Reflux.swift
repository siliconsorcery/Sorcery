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

final public class Reflux<STORE, SERVICE>: ObservableObject {
            
    @Published public var store: STORE
    public var service: SERVICE
    private var middleware: [(Reflux, RefluxAction) -> Bool] = []
    
    public func dispatch(_ action: RefluxAction) {
        
//        guard Thread.isMainThread else {
//            Log.warn("Dispatching must be done on the main thread, while performance testing!")
//            return
//        }
        
        DispatchQueue.main.async {
            var processAction = true
            
            for handler in self.middleware {
                if handler(self, action) == false {
                    processAction = false
                }
            }
            
            if processAction {
                if let action = action as? Action {
                    let realStore = self.store as! Store
                    self.store = realStore.reducer(action) as! STORE
                }
                if let action = action as? Async {
                    action.apply(reflux: self)
                }
            }
        }
    }
    
    public init(
        store: STORE,
        middleware: [(Reflux, RefluxAction) -> Bool] = [],
        service: SERVICE
    ) {
        self.store = store
        self.middleware = middleware
        self.service = service
    }
}

public protocol Store {
    func reducer(_ action: Action) -> Store
}

public protocol Service {}

public protocol RefluxAction: ReflectedStringConvertible {}

public protocol Action: RefluxAction {
    func apply(to store: Store)
}

public protocol Async: RefluxAction {
    func apply(reflux: AnyObject)
}
