//
//  CoreServices.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation

public protocol CoreServices {}

public class MockCoreServices: CoreServices {
    
    public let version = "Mock-AppServices-0.0.0"
    
    public init() {}
}
