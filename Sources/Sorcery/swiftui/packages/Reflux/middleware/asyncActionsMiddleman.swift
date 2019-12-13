//
//  asyncActionsMiddleman.swift
//  Reflux
//
//  Created by John Cumming on 10/21/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

public let kAsyncActionsMiddleman: Middleman<RefluxState, RefluxServices> = { dispatch, getState, getServices in
    return { next in
        return { action in
            if let action = action as? AsyncAction {
                action.execute(state: getState(), services: getServices(), dispatch: dispatch)
            }
            return next(action)
        }
    }
}
