# Celora Flutter App

Flutter port of the Celora interactive phone-app prototype (`celora_app.jsx`).

## Folder structure

```
celora/
├── lib/
│   ├── main.dart
│   ├── models/celora_models.dart
│   ├── providers/app_provider.dart
│   ├── screens/
│   │   ├── main_shell.dart
│   │   ├── onboarding_screen.dart
│   │   ├── home_screen.dart
│   │   ├── tracker_screen.dart
│   │   ├── shop_screen.dart
│   │   ├── checkout_sheet.dart
│   │   ├── impact_screen.dart
│   │   └── profile_screen.dart
│   ├── theme/
│   │   ├── celora_colors.dart
│   │   └── celora_styles.dart
│   ├── utils/
│   │   ├── celora_constants.dart
│   │   └── celora_helpers.dart
│   └── widgets/
│       ├── celora_dot.dart
│       ├── celora_widgets.dart
│       ├── pad_mix_bar.dart
│       └── pad_mix_legend.dart
├── android/
├── pubspec.yaml
└── analysis_options.yaml
```

## Run

```bash
cd celora
flutter pub get
flutter run
```

If platform files are incomplete on your machine, regenerate them once:

```bash
flutter create . --org com.celora
```

## Features converted

- 4-step onboarding quiz with progress bar
- Home dashboard with cycle prediction and kit overview
- Cycle tracker calendar with period/fertile day highlighting
- Subscription shop with modal checkout sheet
- Impact stats and community goal progress
- Profile screen with restart onboarding
- Bottom tab navigation (5 tabs)
- Provider-based app state

## Dependencies

- `provider` — state management (replaces React `useState`)
- `google_fonts` — serif/sans typography (Georgia / Segoe UI equivalent)
- `intl` — date formatting
