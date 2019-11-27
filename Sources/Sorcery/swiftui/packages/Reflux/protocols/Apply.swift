//
//  Apply.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

public typealias Apply<S> = (_ state: S, _ command: Action) -> S