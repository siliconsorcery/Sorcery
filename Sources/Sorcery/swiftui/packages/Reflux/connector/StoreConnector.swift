//
//  StoreConnector.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct StoreConnector<S: RefluxState, C: CoreServices, V: View>: View {
    
    @EnvironmentObject var store: Store<S, C>
    
    let content: (S, @escaping Dispatch) -> V
    
    public var body: V {
        content(
            store.state,
            store.dispatch
        )
    }
}
