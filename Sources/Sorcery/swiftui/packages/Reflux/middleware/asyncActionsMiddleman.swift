//
//  asyncActionsMiddleman.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

public let asyncActionsMiddleman: Middleman<RefluxState> = { dispatch, getState in
    return { next in
        return { action in
            if let action = action as? AsyncAction {
                action.execute(state: getState(), dispatch: dispatch)
            }
            return next(action)
        }
    }
}
