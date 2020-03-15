//
//  KeyboardHost.swift
//  Sorcery
//
//  Created by John Cumming on 11/12/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//
//  See: Benjamin Kindle answer Jul 27, 2019 at 18:42
//  https://stackoverflow.com/questions/56491881/move-textfield-up-when-thekeyboard-has-appeared-by-using-swiftui-ios
//

import SwiftUI

public struct KeyboardHost<Content: View>: View {
    
    public var body: some View {
        VStack {
            view
                .padding(.bottom, keyboardHeight)
        }
        .onReceive(showPublisher.merge(with: hidePublisher)) { height in
            withAnimation(.spring()) {
                self.keyboardHeight = height
            }
        }
    }
    
    // MARK: - Properties

    let view: Content

    public init(@ViewBuilder content: () -> Content) {
        view = content()
    }
       
    @State private var keyboardHeight: CGFloat = 0

    private let showPublisher = NotificationCenter
        .Publisher(
            center: .default,
            name: UIResponder.keyboardWillShowNotification
        )
        .map { notification -> CGFloat in
            if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                return rect.size.height - 34.0 // HACK
            } else {
                return 0
            }
        }

    private let hidePublisher = NotificationCenter
        .Publisher(
            center: .default,
            name: UIResponder.keyboardWillHideNotification
        )
        .map { _ -> CGFloat in
            0
        }

}
