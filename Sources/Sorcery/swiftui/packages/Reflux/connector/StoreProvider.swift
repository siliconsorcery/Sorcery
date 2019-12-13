//
//  StoreProvider.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct StoreProvider<S: RefluxState, C: RefluxServices, V: View>: View {
    public let store: Store<S, C>
    public let content: () -> V
    
    public init(
        store: Store<S, C>,
        content: @escaping () -> V
    ) {
        self.store = store
        self.content = content
    }
    
    public var body: some View {
        content()
        .environmentObject(store)
    }
}
