//
//  TriFlux.swift
//  Sorcery
//
//  Created by John Cumming on 5/24/20.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

/// StoreMaker

public class TriFlux: ObservableObject {
}

final public class TriFluxStore<MODEL, SERVICE>: ObservableObject {
    
    @Published public var state: MODEL
    public var service: SERVICE
    public var id = ""
    
    private var pending: [() -> Void] = []
    private var isReady = true
    
    public init(
        id: String? = nil
        ,state: MODEL
        ,service: SERVICE
    ) {
        self.state = state
        self.service = service
        self.id = id ?? "TriFlux"
    }
    
    public func dispatch(action: @escaping () -> Void) {
        
        pending.append(action)
        
        if isReady {
            isReady = false
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isReady = true
                
                guard self.pending.isEmpty == false else { return }
                let pending = self.pending
                self.pending.removeAll()
                
                for action in pending { action() }
                if pending.count > 1 {
                    Log.echo("\(self.id) 📦 🚀 Asynced: \(pending.count) Action\(pending.count == 1 ? "" : "s")")
                }
                
                // Signal state has changed, combine will re-evaluate store dependencies
                self.state = self.state as MODEL
            }
        }
    }
    
    public static func dispatch(
        _ store: TriFluxStore
        ,_ message: String = "❤️"
        ,funcName: String = #function
        ,fileName: String = #file
        ,lineNumber: Int = #line
        ,action: @escaping () -> Void
    ) {
        Log.echo(
            "\(store.id) 📦 \(message)"
            ,funcName: funcName
            ,fileName: fileName
            ,lineNumber: lineNumber
        )
        store.dispatch { action() }
    }
    
}
