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
    private var middleware: [(Reflux, RefluxOrder) -> Bool] = []
    private var pending: [Action] = []
    private var isReady = true
    
    public func dispatch(_ order: RefluxOrder) {
        
        var doWork = true
        for middle in self.middleware {
            if middle(self, order) == false {
                doWork = false
            }
        }
        
        if doWork {

            if let action = order as? Command {
                // Command ( Should dispatch(Action) to change store.state )
                action.apply(reflux: self)
                
            } else if let action = order as? Action {
                // Action ( Should change stote.state )
                pending.append(action)
            
                if isReady {
                    isReady = false

                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.isReady = true
                        
                        guard self.pending.isEmpty == false else { return }
                        let pending = self.pending
                        self.pending.removeAll()
                        
                        if pending.count > 1 { Log.echo("🚀 Asynced: \(pending.count) Actions") }
                        var store = self.store as! Store
                        for action in pending {
                            store = store.reducer(action)
                        }
                        self.store = store as! STORE
                    }
                }
            }
        }
    }
    
    public init(
        store: STORE,
        middleware: [(Reflux, RefluxOrder) -> Bool] = [],
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

public protocol RefluxOrder: ReflectedStringConvertible {}

public protocol Action: RefluxOrder {
    func apply(to store: Store)
}

public protocol Command: RefluxOrder {
    func apply(reflux: AnyObject)
}
