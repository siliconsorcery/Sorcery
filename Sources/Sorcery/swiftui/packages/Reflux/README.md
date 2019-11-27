# Reflux - Based on SwiftUIFlux
A very naive implementation of Redux using Combine BindableObject to serve as an example

`Store`

`Reflux` (was FluxState)

`Middleman` (was Middleware)

`Apply` (was Reducer)

(was Dispatch)


## Usage

In this little guide, I'll show you two ways to access your proprerties from your `state`, one very naive, which works by using direct access to `store.state` global or injected `@EnvironmentObject` and the other one if you want to use `ConnectedView`.

You first have to make a class which will contain your application state and it needs to conform to `ReFluxState`. You can add any substate you want.

The application state also needs an `apply` function that executes the action's `apply` method that in turn updates the `state`.

``` Swift
import Sorcery

class AppState: RefluxState {
    var moviesState = MoviesState()

    static func apply(
        state: AppState,
        action: Action
    ) -> AppState {
        action.apply(to: state.moviesState)
        return state
    }
}

class MoviesState: RefluxState, Codable {
    var movies: [Int: Movie] = [:]
}

class Movie: Identifiable, Codable {
    let id: Int
    let original_title: String
    let title: String
}
```

Finally, you have to add you `Store` which will contain you current application state `AppState` as a global constant or contain in a root `View`.

## Global State

You instantiate with your initial application `state`, any `middleman` and your main `apply` function.

And now the part where you inject it in your SwiftUI app.
The most common way to do it is in your `SceneDelegate` when your initiate your view hierarchy is created. You should use the provided `StoreProvider` to wrap you whole app root view hiearchy inside it. It'll auto magically inject the store as an `@EnvironmentObject` in all your views.

```Swift
let store = Store<AppState>(
    state: AppState(),
    middleman: [],
    apply: AppState.apply
)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene, 
        willConnectTo session: UISceneSession, 
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let controller = UIHostingController(rootView:
                StoreProvider(store: store) {
                    HomeView()
                }
            )

            window.rootViewController = controller
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

```

In View

```Swift
struct MyRootView: View {

    var body: some View {
        RStoreProvider(store: store) {
            HomeView()
            .onAppear { Log.task() }
            .onDisappear { Log.task() }
        }
    }

    @State private var store = Store<AppState>(
        state: AppState(),
        middleman: [],
        apply: AppState.apply
    )
}
```

From there, there are two ways to access your `state` properties.

In any `view` where you want to access your application state, you can do it using `@EnvironmentObject`

``` Swift
struct MovieDetail : View {
    @EnvironmentObject var store: Store<AppState>

    let movieId: Int

    var movie: Movie {
        return store.state.moviesState.movies[movieId]
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                MovieBackdrop(movieId: movie.id)
                // ...
            }
        }
    }
}
```

This is the naive, brutal, not so redux compliant way, but it works.

Note that any `view` where you add explicilty add `@EnvironmentObject var store: Store<AppState>`will be redraw anywhere it's needed as your state is updated. The diff is done at the view level by SwiftUI.

And it's efficient enough that this library don't have to provide custom subscribers or a diffing mechanism. This is where it shine compared to a UIKit implementation.

You can also use `ConnectedView,` this is the new prefered way to do it as it feels more redux like. But the end result is exactly the same. You just have a better separation of concerns, no wild call to store.state and proper local properties.

``` Swift
struct MovieDetail : ConnectedView {

    let movieId: Int

    struct Props {
        let movie: Movie
    }

    func map(
        state: AppState, 
        dispatch: @escaping DispatchFunction
    ) -> Props {
        return Props(
            movie: state.moviesState.movies[movieId]!
        )
    }

    func body(props: Props) -> some View {
        ZStack(alignment: .bottom) {
            List {
                MovieBackdrop(movieId: props.movie)
                // ...
            }
        }
    }
}
```

You have to implement a map function which convert properties from your state to local view props. And also a new body method which will provide you with your computed props at render time.

At some point, you'll need to make changes to your state, for that you need to create and dispatch `Action`

`AsyncAction` is available as part of this library, and is the right place to do network query, if'll be executed by an internal `middleman` when you dispatch it.

You can then chain any action when you get a result or an error.

``` Swift
struct MoviesActions {
    struct FetchDetail: AsyncAction {
        let movie: Int

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            APIService.shared.GET(endpoint: .movieDetail(movie: movie))
            {
                (result: Result<Movie, APIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetDetail(movie: self.movie, movie: response))
                case .failure(_):
                    break
                }
            }
        }
    }

    struct SetDetail: Action {
        let movie: Int
        let movie: Movie
    }

}
```

And then finally, you can `dispatch` them, if you look at the code of the `apply` at the begining of this readme, you'll see how `action` are `applied`. The `apply` is the only function where you are allowed to mutate your `state`.

As everything in the AppState are Swift `class`, you actually return the modified `state` from an `apply` method. In addition, nothing prevents write operations outside of the 'apply' methods. This aligns poorly with the Redux achitecture.

``` Swift
struct MovieDetail: View {
    @EnvironmentObject var store: Store<AppState>

    let movieId: Int

    var movie: Movie {
        return store.state.moviesState.movies[movieId]
    }

    func fetchMovieDetails() {
        store.dispatch(
            action: MoviesActions.FetchDetail(movie: movie.id)
        )
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                MovieBackdrop(movieId: movie.id)
                // ...
            }
        }.onAppear {
            self.fetchMovieDetails()
        }
    }
}
```
