# Reflux 
A very naive implementation of Redux using Apple's SwiftUI and Combine BindableObject. It extends the Redux store model to provide access to services and dispatch fuctions.

## Usage

In this little guide, I'll show you how to access proprerties from your state, call services and dispatch direct and indirect actions.

The `Reflux` model manages a state `store`, [`middleman`] and `serivce`. It is based on the Redux model https://redux.js.org/ with the addition of Services

The `store` represents the single source of truth of state, must implement a reducer (apply function) that mutates state from old to new. 

The [`middleman`] is an array of `Middleman` functions that are called on the dispatch of every `Action`. This provides hooks for centralized logic to process Action streams. Usefull for logging, undo, recording.

`service` represents the business logic service that are available to the `Reflux` instance. 

# First

We have to create a `Reflux` instance and inject it into our view hierarchy. Lifecycle `.onAppear'` and `.onDisappear` modifiers can be used aid setup and teardown.

A typealias concretly defines the classes we are using in our `Reflux` instance. This is used in our `View` when getting a reference to our `Reflux` instance.

``` Swift

import Sorcery
import SwiftUI

typealias AppReflux = Reflux<AppStore, AppService>

struct ContentView: View {

    private var reflux = Reflux(
        store: AppStore(),
        middleman: [kEchoMiddleman],
        service: AppService()
    )

    var body: some View {
        Home()
            .environmentObject(reflux)
            .onAppear { self.startup() }
        }
    }

    private func startup() {
        reflux.dispatch(SessionState.Listen())
    }
}

```

Any view down the hierarchy can access the `reflux` from the `@EnviromentObject`.

It is recommended that state information and actions be localized for each view. This can be accomplished with a local `Props` struct and a mapping function. During mapping it's expected that `Props` members will be presented as needed by the View.

``` Swift

import Sorcery
import SwiftUI

struct Home: View {

    @EnvironmentObject var reflux: AppReflux

    var body: some View {
        let props = map(reflux)
        
        return Column {
            Text("Hello Again")
            Text("\(props.seriveVersion)")
            Text("\(props.count)")
            Button(action: props.increment) {
                Text("Increment")
            }
            Button(action: { props.delayIncrement(2.0) }) {
                Text("Delayed")
            }
        }
    }
    
    // MARK: - Props
    
    struct Props {
        let seriveVersion: String
        let count: String
        let increment: () -> Void
        let delayIncrement: (Double) -> Void
    }
    
    func map(_ reflux: AppReflux) -> Props {
        return Props(
            seriveVersion: "Running: \(reflux.service.version)",
            count: "Count: \(reflux.store.countStore.data.counter)",
            increment: { reflux.dispatch(CountStore.Increment()) },
            delayIncrement: { delay in reflux.dispatch(CountStore.DelayIncrement(delay: delay)) }
        )
    }
}
```

Note that any view where you add explicilty add `@EnvironmentObject var reflux: AppReflux` will be redraw anywhere it's needed as your state is updated. The diff is done at the view level by SwiftUI. 

And it's efficient enough that this library don't have to provide custom subscribers or a diffing mechanism. This is where it shine compared to a UIKit implementation. 

Make classes that will be used to represent your application state. These classes need to implement the `Store` protocol from `Reflux`.

At some point, you'll need to make changes to your state, for that you need to create and dispatch `Action`

`Async` is available as part of this library, and is the right place to do network query, if'll be executed by an internal `middleware` when you dispatch it.

`Async` commands have access to the full set of services managed by the `Reflux` instance. These services can be used to preform asynchronous work. Any results that require state change must dispatch an `Action` to preform the mutation.

A useful pattern is to create a nested `Model` struct to represent state.

``` Swift
import Sorcery

class CountStore: Store, Codable {

    var data = Model()

    struct Model: Codable {
        var counter: Int
    }

    init() {
        self.counter = 0
    }

    func apply(_ action: Action) -> {
        action.apply(to: self)
        retun self
    }

    class Increment: Action {
        func apply(to: store: Store) {
            guard let store = store as? CounterStore else { return }
            store.date.counter += 1
        }
    }

    class DelayIncrement: Async {
        let delay: Double
        
        init(delay: Double) {
            self.delay = delay
        }
        
        func apply(store: Store?, service: Service?, dispatch: @escaping Dispatch) {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                dispatch(CountState.Increment())
            }
        }
    }
}
```

`Reflux` manages state in a single `Store` instance. (Single Source of Truth).

The base store object implements the `Store` protocol. In doing so, it provides a reducer function called `apply` that's use to mutate state.

The base store object can be composed of other `Store`s objects.

The `Store` protocol requires an apply function that will be called when an action is dispatched. This function acts as the reducer, it takes the current state and mutates it to a new state. SwiftUI handles the reactions to the state changes by redrawing the UI as needed. This is achieved by using and `.enviromentObject` for the `Reflux` object.

``` Swift
import Sorcery

struct AppStore: Store, Codable {
    var countStore: CountStore
    var settingsStore: SettingsStore
    var routerStore: RouterStore

    func apply(_ action: Action) -> Store {
        action.apply(to: countStore)
        action.apply(to: settingsStore)
        action.apply(to: routerStore)
        return self
    }
}
```

Next we need to define the optional `middleman` processes that will run every time an action is dispatched.

For example, the following middleman logs all `Actions` to the console.

``` Swift
import Sorcery

let kEchoMiddleman: Middleman<AppStore, AppService> = { dispatch, getStore, getService in
    { next in
        { action in
            #if DEBUG
            
            let name = __dispatch_queue_get_label(nil)
            let queueName = String(cString: name, encoding: .utf8)
            assert(queueName == "com.apple.main-thread")
            
            let actionTitle = "\(String(reflecting: type(of: action)))"
            var parts = actionTitle.components(separatedBy: ".")
            parts.remove(at: 0) // Remove 'FireList'
            parts.removeLast() // Remove 'Action'

            let kind = parts.joined(separator: ".")
            
            Log.echo("\(kind).\(action)")

            #endif
            return next(action)
        }
    }
}
```

A service class is defined to access to system and network services. This class conforms to the `Service` protocol.

``` Swift
import Sorcery

class AppService: Service {
    
    var version: String = "AppService-0.0.1"
    
    static var singleton = AppService()

    var authentication: AuthenticationDelegate?
    var database: DatabaseDelegate?

    override init() {
        super.init()

        // Startup Firebase
        FirebaseApp.configure()

        // Instance concrete Services
        database = FirestoreDatabase()
        authentication = GoogleAuthentication()
        
    }

    deinit {
    }
}
```


