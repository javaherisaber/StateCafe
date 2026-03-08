# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run Commands

```bash
flutter pub get                  # Install dependencies
flutter gen-l10n                 # Generate localization files (required after ARB changes)
flutter analyze                  # Static analysis (flutter_lints)
flutter test                     # Run all tests
flutter test test/widget_test.dart  # Run a single test file
flutter run                      # Run on connected device
flutter run -d chrome            # Run on web
```

## Architecture

This is an educational Flutter app (StateCafe) demonstrating **different parallel state management approaches** side by side:

- **BLoC** (`lib/src/bloc/`) — primary, used by default via `runBlocEntry()` in `main.dart`
- **RxDart** (`lib/src/rx/`) — alternative implementation using `BehaviorSubject` streams

Both have identical screen structure (`app/`, `screens/home/`, `screens/login/`, `screens/settings/`, `screens/splash/`) with their own `entry_point.dart` and `routes.dart`.

### Key directories

- `lib/data/` — Models (`DrinkData` using Equatable), enums (`DrinkType`), repository pattern with caching, SharedPreferences wrapper
- `lib/extensions/` — Kotlin-style extensions on `BuildContext` and `Object` (`let`, `also`, `errorIfNull`)
- `lib/base/` — `ResourcefulState` (extends `LifecycleAwareState`), global utility functions
- `lib/themes/` — Custom icon font (`AppIcons`), locale configuration (`AppLocale`)
- `lib/widgets/` — Shared view components (`DrinkView`, `SplashView`, `Space`)
- `lib/l10n/` — Generated localization output (do not edit manually)
- `l10n/` — ARB source files (`intl_en.arb`, `intl_fa.arb`)
- `assets/` — JSON drink data (`coffee.json`, `tea.json`, `juice.json`) and images per drink type

### Global accessors

`lib/base/first_class_functions.dart` provides globals via `navigatorKey.currentContext`:
- `tr` — `AppLocalizations` instance for translations
- `tp` — `TextTheme` instance for typography

### Navigation

Named routes (`/splash`, `/login`, `/home`, `/settings`) via `Navigator.pushNamed`/`pushReplacementNamed`. Route maps defined separately for each state management approach.

### Localization

- Two locales: English (`en`, template) and Persian (`fa`)
- ARB files in `l10n/`, generated output in `lib/l10n/`
- Config in `l10n.yaml` with `output-dir: lib/l10n`
- Import as `package:state_cafe/l10n/app_localizations.dart`
- Access via `context.intl` extension or global `tr`

### BLoC conventions

- Events and states in `part` files alongside the bloc
- All states extend Equatable
- Screen blocs: events trigger state transitions, UI rebuilds via `BlocBuilder`/`BlocConsumer`

### Data flow

Drink data is loaded from JSON assets → `Repository` (with in-memory cache and simulated delay) → BLoC/RxDart → UI via `DrinkView` GridView.