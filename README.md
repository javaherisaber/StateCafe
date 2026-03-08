# StateCafe

A Flutter tutorial app that demonstrates **8 different state management approaches** side by side, all implementing the same UI and business logic. Compare how each approach handles reactive state, navigation side-effects, dependency injection, and app-level concerns like locale switching.

## Live demo
[![Live Demo](https://img.shields.io/badge/Live-Demo-blue)](https://buildtoapp.com/gh/state-cafe)

## Quick Start

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs  # MobX code generation
flutter run -d chrome
```

## Switching Between Approaches

Open `lib/main.dart` and change the `_currentApproach` constant:

```dart
enum StateApproach { bloc, rx, provider, riverpod, redux, getit, getx, mobx }

const _currentApproach = StateApproach.bloc; // Change this line
```

Each approach implements the same 4 screens:
- **Splash** — 4-second timer, check login status, navigate
- **Login** — form validation (`admin`/`admin`), save login state
- **Home** — load drinks from JSON assets, bottom navigation (Coffee/Tea/Juice)
- **Settings** — preferred drink, language toggle (English/Persian), logout

## App Architecture

```
lib/
├── main.dart                  # Entry point with StateApproach switch
├── base/                      # ResourcefulState, global functions (tr, tp)
├── data/                      # DrinkData model, DrinkType enum, Repository, SharedPreferences
├── extensions/                # BuildContext and Object extensions
├── l10n/                      # Generated localization files
├── themes/                    # Custom icons, locale configuration
├── widgets/                   # Shared widgets (DrinkView, SplashView, Space)
└── src/
    ├── bloc/                  # 1. BLoC
    ├── rx/                    # 2. RxDart
    ├── provider/              # 3. Provider
    ├── getit/                 # 4. GetIt
    ├── getx/                  # 5. GetX
    ├── riverpod/              # 6. Riverpod
    ├── redux/                 # 7. Redux
    └── mobx/                  # 8. MobX
```

Each approach directory follows the same structure:
```
<approach>/
├── entry_point.dart           # async Future<Widget> runXxxEntry()
├── routes.dart                # XxxRoutes with route map
├── app/                       # Root MaterialApp + app-level state (locale)
└── screens/
    ├── splash/                # Timer + login check + navigation
    ├── login/                 # Credentials + navigation
    ├── home/                  # Drinks from Repository + bottom nav
    └── settings/              # Preferred drink + language + logout
```

---

## 1. BLoC (`lib/src/bloc/`)

**Package:** `flutter_bloc`

**Core concepts:** Events are dispatched to a `Bloc`, which processes them and emits new `State` objects. States extend `Equatable` for efficient equality checks.

**State management:**
- `AppBloc` at the root via `BlocProvider` — manages locale
- Screen blocs (`SplashBloc`, `LoginBloc`, `HomeBloc`, `SettingsBloc`) created per-screen via `BlocProvider`
- Events defined as `part` files alongside the bloc class

**Navigation side-effects:** `BlocListener` / `BlocConsumer` reacts to specific state types and triggers navigation imperatively.

**Pros:**
- Strong separation of concerns (events → bloc → states)
- Predictable, testable state transitions
- Large ecosystem and community

**Cons:**
- Significant boilerplate (events, states, bloc classes)
- Part files add complexity

---

## 2. RxDart (`lib/src/rx/`)

**Package:** `rxdart`, `live_event`

**Core concepts:** Plain Dart classes using `BehaviorSubject` for stateful data streams and `LiveEvent` for single-fire navigation events. Manual `InheritedWidget` for dependency injection.

**State management:**
- `AppBloc` provided via custom `AppProvider` (InheritedWidget)
- Screen blocs are plain classes created in `initState()`, disposed manually
- `StreamBuilder` for reactive UI rebuilds

**Navigation side-effects:** `Stream.listen()` on `LiveEvent` streams (single-fire, not replayed to new listeners).

**Pros:**
- No framework dependency beyond rxdart — pure Dart patterns
- Full control over stream composition
- Lightweight

**Cons:**
- Manual dispose management
- No built-in dev tools
- `LiveEvent` needed to prevent stream replay issues

---

## 3. Provider (`lib/src/provider/`)

**Package:** `provider`

**Core concepts:** `ChangeNotifier` classes hold mutable state and call `notifyListeners()`. Provided to the widget tree via `ChangeNotifierProvider` and consumed with `context.watch()` / `context.read()` / `Consumer`.

**State management:**
- `AppNotifier` at root via `ChangeNotifierProvider`
- Screen notifiers created per-screen via `ChangeNotifierProvider`

**Navigation side-effects:** Flag-and-consume pattern — notifier sets a boolean flag, widget checks it in `build()`, consumes it, and triggers navigation via `addPostFrameCallback`.

**Pros:**
- Simple mental model — just `ChangeNotifier` + `notifyListeners()`
- Minimal boilerplate
- Flutter team recommended for beginners

**Cons:**
- Navigation side-effects require flag pattern (not as clean as streams)
- `notifyListeners()` rebuilds all consumers (no selective listening)

---

## 4. GetIt (`lib/src/getit/`)

**Package:** `get_it`

**Core concepts:** Service locator pattern — register singletons/factories in a central `setupServiceLocator()` function, retrieve them anywhere via `getIt<T>()`. Same `ChangeNotifier` classes as Provider, but wired via `addListener` instead of Provider widgets.

**State management:**
- `AppNotifier` registered as singleton in `setupServiceLocator()`
- Screen notifiers created locally, wired via `addListener` / `removeListener`
- `setState()` called from listeners for reactive UI

**Navigation side-effects:** `addListener` callback checks flags and triggers navigation directly.

**Pros:**
- No widget tree coupling — access services from anywhere
- Simple API: `getIt<T>()`
- Works great for non-UI services too

**Cons:**
- Manual listener management and disposal
- No built-in reactivity for the widget tree — must use `setState` or `ListenableBuilder`
- Service locator is a global mutable registry

---

## 5. GetX (`lib/src/getx/`)

**Package:** `get`

**Core concepts:** `GetxController` with `.obs` reactive variables. `Obx()` widget automatically tracks and rebuilds on changes. `Get.put()` / `Get.find()` for controller injection.

**State management:**
- `AppController` registered globally via `Get.put()` in entry point
- Screen controllers created via `Get.put()` in `initState()`, deleted in `dispose()`
- Reactive variables: `final name = 'value'.obs`

**Navigation side-effects:** `ever()` / `once()` workers react to observable changes and trigger navigation.

**Pros:**
- Minimal boilerplate — `.obs` + `Obx()` is very concise
- Built-in dependency injection, routing, and utilities
- Auto-disposal with `GetxController` lifecycle

**Cons:**
- Opinionated "all-in-one" framework
- Implicit magic can make debugging harder
- Large API surface to learn

---

## 6. Riverpod (`lib/src/riverpod/`)

**Package:** `flutter_riverpod`

**Core concepts:** Providers declared as top-level globals, scoped via `ProviderScope`. `StateNotifier` + `StateNotifierProvider` for state management. `ConsumerWidget` / `ConsumerStatefulWidget` for consuming state. `ref.watch()` / `ref.read()` / `ref.listen()` for reactive access.

**State management:**
- `appProvider` (global) for app-level locale state
- `splashProvider` as `FutureProvider.autoDispose` for the timer
- Screen providers with `StateNotifier` holding immutable state objects
- All providers declared in `providers.dart`

**Navigation side-effects:** `ref.listen()` reacts to state changes and triggers navigation imperatively.

**Pros:**
- Compile-safe — no runtime `context.read<T>()` failures
- `autoDispose` for automatic cleanup
- Testable — providers can be overridden
- Immutable state objects

**Cons:**
- Learning curve (provider types, ref semantics)
- More verbose than Provider for simple cases
- `StateNotifier` deprecated in newer versions (replaced by `Notifier`)

---

## 7. Redux (`lib/src/redux/`)

**Packages:** `redux`, `flutter_redux`, `redux_thunk`

**Core concepts:** Single `Store<AppState>` with a combined reducer tree. Actions describe what happened, reducers produce new state, thunk middleware handles async operations. `StoreProvider` at root, `StoreConnector` in widgets.

**State management:**
- Single `AppState` containing sub-states for each screen
- `appReducer` delegates to screen-specific reducers
- `thunkMiddleware` enables async actions (API calls, SharedPreferences)
- Actions, reducers, state, and middleware in separate files per screen

**Navigation side-effects:** `StoreConnector.onDidChange` callback compares previous and current state to trigger navigation.

**File structure (most files of any approach):**
```
redux/
├── app/
│   ├── app.dart, app_state.dart, app_actions.dart, app_reducer.dart, app_middleware.dart
└── screens/<screen>/
    ├── <screen>.dart, <screen>_state.dart, <screen>_actions.dart,
    ├── <screen>_reducer.dart, <screen>_middleware.dart
```

**Pros:**
- Predictable, time-travel debuggable state
- Single source of truth
- Well-established pattern from web development

**Cons:**
- Most boilerplate of all approaches
- Many files per feature (actions, reducers, middleware, state)
- Overkill for small apps

---

## 8. MobX (`lib/src/mobx/`)

**Packages:** `mobx`, `flutter_mobx`, `mobx_codegen` (dev)

**Core concepts:** Store classes with `@observable` fields and `@action` methods. `Observer()` widget from `flutter_mobx` auto-tracks observables and rebuilds. Requires code generation via `build_runner`.

**State management:**
- `AppStore` provided down the tree via `MobXAppProvider` (InheritedWidget)
- Screen stores created locally in `initState()`
- Mixin pattern: `class MyStore = _MyStore with _$MyStore`

**Navigation side-effects:** `reaction()` watches observable changes and triggers side-effects. Returns a disposer function that must be called in `dispose()`.

**Code generation:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**Pros:**
- Minimal boilerplate in store classes — just annotate fields and methods
- Fine-grained reactivity — only affected `Observer` widgets rebuild
- `reaction()` / `when()` / `autorun()` for flexible side-effects

**Cons:**
- Requires code generation step
- Generated `.g.dart` files add to the codebase
- Mutable state (unlike BLoC/Redux immutable patterns)

---

## Comparison Table

| Feature | BLoC | RxDart | Provider | GetIt | GetX | Riverpod | Redux | MobX |
|---------|------|--------|----------|-------|------|----------|-------|------|
| **Boilerplate** | High | Medium | Low | Low | Very Low | Medium | Very High | Low* |
| **Reactivity** | BlocBuilder | StreamBuilder | Consumer/watch | addListener | Obx | ref.watch | StoreConnector | Observer |
| **Side-effects** | BlocListener | Stream.listen | Flag pattern | addListener | ever/once | ref.listen | onDidChange | reaction |
| **DI mechanism** | BlocProvider | InheritedWidget | ChangeNotifierProvider | GetIt.instance | Get.put/find | ProviderScope | StoreProvider | InheritedWidget |
| **State style** | Immutable | Mutable streams | Mutable | Mutable | Mutable (.obs) | Immutable | Immutable | Mutable |
| **Async** | In bloc handler | In bloc class | In notifier | In notifier | In controller | FutureProvider/notifier | Thunk middleware | In @action |
| **Code gen** | No | No | No | No | No | No | No | Yes |
| **Testability** | Excellent | Good | Good | Good | Fair | Excellent | Excellent | Good |
| **Learning curve** | Medium | Medium | Low | Low | Low | Medium-High | High | Low-Medium |

*\*MobX boilerplate is low in hand-written code but generates `.g.dart` files.*

## Shared Code

All 8 approaches share:
- **Data layer** (`lib/data/`) — `DrinkData`, `DrinkType`, `Repository`, `AppSharedPreferences`
- **Widgets** (`lib/widgets/`) — `DrinkView`, `SplashView`, `Space`, `EmptyBox`
- **Themes** (`lib/themes/`) — `AppIcons`, `AppLocale`
- **Extensions** (`lib/extensions/`) — `BuildContext` and `Object` extensions
- **Base** (`lib/base/`) — `ResourcefulState`, global `tr`/`tp` accessors
- **Localization** (`lib/l10n/`, `l10n/`) — English and Persian

## License

This project is for educational purposes.
