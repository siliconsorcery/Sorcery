//
//  RefluxServices.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation

public protocol RefluxServices {}

public class MockCoreServices: RefluxServices {
    
    public let version = "Mock-AppServices-0.0.1"
    
    public init() {}
}
