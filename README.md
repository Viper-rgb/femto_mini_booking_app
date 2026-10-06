<p align="center">
  <img src="docs/logo.png" alt="Famto logo" width="140"/>
</p>

<h1 align="center">Famto Mini Service Booking</h1>

<p align="center">
  A Flutter app for discovering and booking trusted home services — electrician, plumber, AC repair, cleaning and painting.
</p>

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white"/>
  <img alt="Dart" src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white"/>
  <img alt="Platform" src="https://img.shields.io/badge/Platform-Android-3DDC84?logo=android&logoColor=white"/>
</p>

## Screenshots

<p align="center">
  <img src="docs/home_screen.png" alt="Home screen" width="260"/>
</p>

## Features

- Home screen with location selector, service search and category shortcuts
- Popular services carousel with ratings and pricing
- Service category listing and service details
- Booking flow with date and time pickers
- Booking confirmation with price breakdown
- My Bookings (upcoming / previous) and profile section
- Login and registration screens
- State management with `provider` (loading, error and empty states)

## Tech Stack

- **Framework:** Flutter (Material 3)
- **State management:** Provider
- **Language:** Dart

## Project Structure

```text
lib/
├── main.dart
├── models/        # Data models (service_model.dart)
├── providers/     # State management (service_provider.dart)
└── screens/       # Home, category, details, booking, confirmation,
                   # bookings, login and register screens
```

## Getting Started

```bash
git clone https://github.com/Viper-rgb/femto_mini_booking_app.git
cd femto_mini_booking_app
flutter pub get
flutter run
```

## Build an APK

```bash
flutter build apk --release
```

The APK is generated at `build/app/outputs/flutter-apk/app-release.apk`.
