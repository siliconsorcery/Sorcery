//
//  ImageView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    // MARK: - Lifecycle

    init(
        _ contentMode: ContentMode = .scaleAspectFill,
        frame: CGRect? = nil
    ) {
        super.init(frame: frame ?? .zero)
        self.contentMode = contentMode
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
