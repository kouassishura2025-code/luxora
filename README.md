# LUXORA

> Chauffeur privé & conciergerie de luxe — application Flutter.

[![CI](https://github.com/TON_USER/luxora/actions/workflows/ci.yml/badge.svg)](https://github.com/TON_USER/luxora/actions/workflows/ci.yml)
[![CD Staging](https://github.com/TON_USER/luxora/actions/workflows/cd_staging.yml/badge.svg)](https://github.com/TON_USER/luxora/actions/workflows/cd_staging.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.24.5-blue.svg)](https://flutter.dev)

## À propos

LUXORA est une application de chauffeur privé et conciergerie de luxe.
Design signature : noir obsidienne, or champagne, typographie éditoriale.

## Démarrage

    flutter pub get
    flutter run -t lib/main_dev.dart -d chrome

## Architecture

    lib/
    ├── app/              # MaterialApp, router, shell, guards
    ├── core/             # config, DI, services
    ├── design_system/    # fondations + composants
    └── features/         # auth, onboarding, home, booking,
                          # fleet, concierge, driver, profile,
                          # membership, safety, notifications

## Design system

- **Couleurs** : obsidienne #0B0B0D, or champagne #C9A24B
- **Typographie** : Playfair Display + Manrope
- **Motion** : transitions lentes, courbes douces

## CI/CD

- **CI** : analyze + tests + build APK debug sur chaque PR
- **CD staging** : APK artifact sur push develop

## Secrets GitHub (optionnels)

- ANDROID_GOOGLE_SERVICES_JSON_B64
- FIREBASE_OPTIONS_B64
- FIREBASE_ANDROID_APP_ID
- FIREBASE_SERVICE_ACCOUNT_STAGING

## License

Propriétaire — © 2026 LUXORA.
# luxora

LUXORA — Chauffeur privé & conciergerie de luxe.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
