//
//  ConnectedView.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public protocol ConnectedView: View {
    associatedtype S: RefluxState
    associatedtype C: CoreServices
    associatedtype Props
    associatedtype V: View
    
    func map(
        state: S,
        services: C,
        dispatch: @escaping Dispatch
    ) -> Props
    
    func body(props: Props) -> V
}

public extension ConnectedView {
    
    func render(
        state: S,
        services: C,
        dispatch: @escaping Dispatch
    ) -> V {
        
        let props = map(
            state: state,
            services: services,
            dispatch: dispatch
        )
        
        return body(props: props)
    }
    
    var body: StoreConnector<S, C, V> {
        return StoreConnector(content: render)
    }
}
