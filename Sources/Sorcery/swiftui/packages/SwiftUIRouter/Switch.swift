//
//  Switch.swift
//  RouterPrototype
//
//  Created by Freek Zijlmans on 15/08/2019.
//  Copyright © 2019 Freek Zijlmans. All rights reserved.
//

import SwiftUI

public struct Switch<Content: View>: View {
    
    public var body: some View {
        contents()
            .environmentObject(SwitchEnviroment(active: true))
    }
    
    // MARK: - Required
    
    @EnvironmentObject var history: HistoryData
    
    public init(@ViewBuilder contents: @escaping () -> Content) {
        self.contents = contents
    }
    
    // MARK: - Private
    
    private let contents: () -> Content
}

final class SwitchEnviroment: ObservableObject {
    
    let isActive: Bool
    var isResolved: Bool = false
    
    init(active: Bool = false) {
        isActive = active
    }
}
