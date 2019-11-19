//
//  LinkButton.swift
//  RouterPrototype
//
//  Created by Freek Zijlmans on 14/08/2019.
//  Copyright © 2019 Freek Zijlmans. All rights reserved.
//

import SwiftUI

public struct Link<Label: View>: View {
    
    public var body: some View {
        Button(action: onClick) {
            content
        }
    }
    
    // MARK: - Required
    
    @EnvironmentObject private var history: HistoryData

    private let content: Label
    private let to: String
    
    public init(
        to: String,
        @ViewBuilder content: () -> Label
    ) {
        self.content = content()
        self.to = to
    }
    
    // MARK: - Private
    
    private func onClick() {
        history.go(to)
    }
}
