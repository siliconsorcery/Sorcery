//
//  StoreProvider.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct StoreProvider<S: RefluxState, V: View>: View {
    public let store: Store<S>
    public let content: () -> V
    
    public init(
        store: Store<S>,
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
