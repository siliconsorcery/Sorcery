# Reflux - Based on SwiftUIFlux

A very naive implementation of Redux using Combine BindableObject to serve as an example

`Store`

`RefluxState` (was FluxState)

`Middleman` (was Middleware)

`Apply` (was Reducer)

`Dispatch` (was DispatchFunction)

## Usage

In this little guide, I'll show you two ways to access your proprerties from your `state`, one very naive, which works by using direct access to `store.state` global or injected `@EnvironmentObject` and the other one if you want to use `ConnectedView`.

You first have to make a class which will contain your application state and it needs to conform to `RefluxState`. You can add any substate you want.

The application state also needs an `apply` function that updates the `state` based on the `action`.

``` Swift
import Sorcery

class AppState: RefluxState {

    var moviesState = MoviesState()
    var peopleState = PeopleState()

    func apply(_ action: Action) -> RefluxState {
        _ = self.moviesState.apply(action)
        _ = self.peopleState.apply(action)
        return self
    }
}

class MoviesState: RefluxState, Codable {
    var data = Model()
    func apply(_ action: Action) -> RefluxState {
        action.apply(to: self)
        return self
    }
    struct Model: Codable {
        var movies: [Int: Movie] = [:]
    }
}

class Movie: Identifiable, Codable {
    let id: Int
    let original_title: String
    let title: String
}

class PeopleState: RefluxState, Codable {

    var data = Model()

    func apply(_ action: Action) -> RefluxState {
        action.apply(to: self)
        return self
    }

    struct Model: Codable {
        var title: String
    }

    class Set: Action {
        let newTitle: String

        init(newTitle: String) {
            self.newTitle = newTitle
        }

        func apply(to state: RefluxState) {
            guard let state = state as? PeopleState else { return }
            state.data.title = newTitle
        }
    }
}
```

Finally, you have to add a `Store` which will contain you current application state `AppState` as a global constant or contain it in a root `View`.

## AppState as a Global

You instantiate a `Store` with your initial application `state`, any `middleman` and your main `apply` function.

And now the part where you inject it in your SwiftUI app.
The most common way to do it is in your `SceneDelegate` when your initiate your view hierarchy is created. You should use the provided `StoreProvider` to wrap you whole app root view hiearchy inside it. It'll auto magically inject the store as an `@EnvironmentObject` in all your views.

```Swift
let store = Store<AppState>(
    state: AppState(),
    middleman: []
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

## AppState in a Root View

```Swift
struct ContentView: View {

    var body: some View {
        StoreProvider(store: store) {
            HomeView()
        }
    }

    @State private var store = Store<AppState>(
        state: AppState(),
        middleman: []
    )
}
```

From there, there are two ways to access your `state` properties.

## Directly use the @EnvironmentObject

In any `view` where you want to access your application state, you can do it using `@EnvironmentObject`

``` Swift
struct MovieDetail: View {

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

## Use the ConnectedView

``` Swift
struct MovieDetail: ConnectedView {

    let movieId: Int

    struct Props {
        let movie: Movie
    }

    func map(
        state: AppState, 
        dispatch: @escaping Dispatch
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

At some point, you'll need to make changes to your state, for that you need to create and dispatch an `Action`

`AsyncAction` is available as part of this library, and is the right place to do network query, if'll be executed by an internal `middleman` when you dispatch it.

You can then chain any `Action` when you get a result or an error.

``` Swift
extension MoviesState {

    class FetchDetail: AsyncAction {

        let movieId: Int

        init(movieId: Int) {
            self.movieId = movieId
        }

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            APIService.shared.GET(endpoint: .movieDetail(movieId: movieId))
            {
                (result: Result<Movie, APIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetDetail(movieId: self.movieId, movie: response))
                case .failure(_):
                    break
                }
            }
        }
    }

    class SetDetail: Action {
        let movieId: Int
        let movie: Movie
    }

}
```

And then finally, you can `dispatch` them, if you look at the code of the `apply` at the begining of this readme, you'll see how `action` are `applied`. The `apply` is the only function where you are allowed to mutate your `state`.

As everything in the `AppState` are made of Swift `class` instances, you actually return the modified `state` from an `apply` method. Class instanaces allows for dynamic dispatch which makes it easy to centralises coding of `Action` and `apply`. In addition, nothing prevents write operations outside of the `apply` methods which is `bad`!. This aligns poorly with the `Redux` achitecture.

``` Swift
struct MovieDetail: ConnectedView {

    let movieId: Int

    struct Props {
        let movie: Movie
        let onAppear: () -> Void
    }

    func map(
        state: AppState,
        dispatch: @escaping Dispatch
    ) -> Props {
        return Props(
            movie: state.moviesState.movies[movieId]!
            onAppear: MoviesActions.FetchDetail(movie: movieId)
        )
    }

    func body(props: Props) -> some View {
        ZStack(alignment: .bottom) {
            List {
                MovieBackdrop(movieId: props.movieId)
                // ...
            }
        }
        .onAppear {
            self.onAppear()
        }
    }
}
```
