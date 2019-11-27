//
//  Middleman.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

public typealias Dispatch = (Action) -> Void

public typealias Middleman<S> = (@escaping Dispatch, @escaping () -> S?)
    -> (@escaping Dispatch) -> Dispatch
