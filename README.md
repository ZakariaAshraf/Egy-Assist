<div align="center">

<img src="assets/icons/icon.png" alt="EgyAssist Logo" width="120"/>

# EgyAssist

### Your Gateway to European Master's Programs

**The app that turns months of scattered research into minutes of smart filtering.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%7C%20Auth-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-blueviolet?style=for-the-badge)](#architecture)

</div>

---

## 📖 The Story Behind EgyAssist

As a Computer Science graduate from Egypt looking to pursue a Master's degree in **Software Engineering**, **Cloud Computing**, or **Data Science** in Europe — specifically Germany and Austria — I faced a massive, frustrating challenge.

Information about university requirements, application portals, deadlines, and language certificates is **extremely scattered**. Every university has a different website, different requirements, and different policies.

The biggest pain point? **The Language Requirement.**

Many students with English-taught Bachelor's degrees struggle with the time and cost of standard English tests (IELTS/TOEFL). Some European universities accept the previous degree as proof of language — known as **MOI (Medium of Instruction)** — but finding which universities actually accept MOI is like looking for a needle in a haystack.

> **EgyAssist was built to solve exactly this.** It aggregates real program data, filters out the noise, and gives students direct, actionable information — with a dedicated **MOI Accepted** filter that saves months of research.

---

## ✨ Features

### 🔐 Authentication & Access
- **Email/Password Sign Up** with client-side validation (email format, password strength requirements with live UI feedback)
- **Sign In** with error handling
- **Guest Mode** — browse the app without creating an account; restricted sections show a clear blur overlay with a "Create Account" prompt
- **Change Password** (Firebase password reset)
- **Delete Account** with confirmation dialog and permanent data removal
- **Profile Editing** — update name, phone number, and avatar

### 🔍 Search & Discovery
- **Full-text search** by university name or program name directly from the home screen
- **Smart Filter** — filter programs by:
  - Country (Germany, Austria, Other European Countries)
  - Field of Study (Computer Science, Business, and more)
  - Language of Instruction (English, German, French, Arabic)
  - Degree Type (Bachelor, Master, PhD)
  - **MOI Accepted** toggle — the key differentiator

### 📌 Favorites & Bookmarks
- Save programs to a personal bookmarks list (logged-in users only)
- Bookmarks persist across sessions via Firestore
- Saved programs section on the Home screen for quick access

### 🌍 Country Guides
- Dedicated country detail screens for Germany, Austria, and other European destinations
- Each guide includes: overview, basic requirements, step-by-step study process, and direct links (Embassy, VFS, Embassy Location)
- "Browse Programs" shortcut from each country guide

### 🎨 Personalization
- **Light / Dark theme** toggle, persisted across sessions
- **English / Arabic (RTL)** full localization — every screen, label, and message is translated
- **Avatar selection** — choose a character during sign-up to personalize the profile

### 📱 UX & Polish
- **Connectivity overlay** — real-time offline banner when the device loses internet
- **Onboarding** — 3-slide introduction on first launch
- **Help & Support** — About Us, Privacy Policy, and Terms & Conditions screens
- **Coming Soon** section for direct scholarship applications
- Push notifications via OneSignal

### 💰 Monetization
- **Banner ads** on the Program Details screen (Google AdMob)
- **Interstitial ads** on the Filter screen (Google AdMob)

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.x (Dart) |
| **Backend / Database** | Firebase Firestore |
| **Authentication** | Firebase Auth |
| **State Management** | Cubit / BLoC (`flutter_bloc`) |
| **Dependency Injection** | Manual (constructor injection via Clean Architecture) |
| **Local Storage** | SharedPreferences (`cache_helper`) |
| **Global State (Theme/Locale)** | Riverpod (`flutter_riverpod`) |
| **Navigation** | Named routes + `Navigator` (root navigator aware for nested tabs) |
| **Ads** | Google AdMob (`google_mobile_ads`) |
| **Push Notifications** | OneSignal (`onesignal_flutter`) |
| **Localization** | Flutter ARB + `AppLocalizations` (EN + AR) |
| **Bottom Navigation** | `persistent_bottom_nav_bar` |
| **Connectivity** | `connectivity_plus` |
| **CI/CD** | Codemagic (GitHub integration, automated Android & iOS builds) |

---

## 🏗️ Architecture

EgyAssist follows **Clean Architecture** with a clear separation of concerns across three layers:

```
lib/
├── core/                          # Shared across all features
│   ├── cache/                     # SharedPreferences wrapper + CacheKeys
│   ├── config/                    # AppInfo (name, version)
│   ├── data/                      # Shared models (AppUserModel, CountryModel)
│   ├── generated/assets/          # Asset path helpers
│   ├── locale/                    # Locale provider (Riverpod) + language toggle
│   ├── services/                  # Firestore service, AdMob manager
│   ├── themes/                    # Theme provider (Riverpod), text themes
│   ├── utils/                     # Colors, screen utils, extensions
│   └── widgets/                   # Reusable widgets (CustomButton, CustomTextField,
│                                  #   GuestRestrictedOverlay, ConnectivityOverlay, ...)
│
├── features/
│   ├── authenticate/
│   │   ├── data/
│   │   │   ├── models/            # UserModel (Firebase ↔ Dart)
│   │   │   └── repositories/      # AuthRepositoryImpl (Firebase Auth)
│   │   ├── domain/
│   │   │   ├── entities/          # UserEntity
│   │   │   ├── repositories/      # AuthRepository (abstract)
│   │   │   └── use_cases/         # SignInUseCase, RegisterUseCase
│   │   └── presentation/
│   │       ├── manager/           # AuthCubit, AuthState
│   │       └── pages/             # SignIn, SignUp, ChooseCharacter, OTP, ChangePassword
│   │
│   ├── favorite/
│   │   ├── cubit/                 # FavouriteCubit, FavouriteState
│   │   ├── views/                 # FavouriteScreen
│   │   └── widgets/               # FavouriteCard
│   │
│   ├── filter/
│   │   └── presentation/
│   │       ├── screens/           # FilterScreen, FilterResultsScreen, ProgramDetailsScreen
│   │       └── widgets/           # FeatureTile, LinkPreviewer
│   │
│   ├── help_support/
│   │   ├── help_support_screen.dart
│   │   └── screens/               # TextContentScreen (About, Privacy, Terms)
│   │
│   ├── home/
│   │   ├── data/model/            # ProgramModel
│   │   └── presentation/
│   │       ├── cubit/             # ProgramsCubit, ProgramsState
│   │       ├── screens/           # HomeScreen, CountryDetailsScreen
│   │       └── widgets/           # UserInfoSection, SearchSection,
│   │                              #   SavedProgramSection, ExploreDestinationSection
│   │
│   ├── notification/
│   │   ├── data/services/         # NotificationServices, NotificationModel
│   │   └── presentation/screens/  # NotificationScreen
│   │
│   ├── onboarding/                # OnboardingScreen (3 slides, first-launch only)
│   │
│   ├── search/
│   │   └── presentation/          # SearchScreen (live search)
│   │
│   └── settings/
│       └── presentation/
│           ├── Cubit/             # UserCubit (Firestore stream), UserState
│           ├── components/        # SettingsButton
│           └── screens/           # SettingView, SettingScreen, EditProfileScreen,
│                                  #   ChangePasswordScreen
│
├── l10n/                          # ARB files + generated AppLocalizations (EN + AR)
├── main.dart                      # App entry, Firebase init, MobileAds init, startWidget logic
└── main_screen.dart               # PersistentTabView (Home, Search, Bookmarks, Profile)
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.8.1`
- Dart SDK `>=3.x`
- A Firebase project (Firestore + Firebase Auth enabled)
- A Google AdMob account (optional for development)

### 1. Clone the repository

```bash
git clone https://github.com/ZakariaAshraf/egyassist.git
cd egyassist
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Firebase setup

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add an Android app (`com.egyassist.app`) and an iOS app (`com.egyassist.app`)
3. Download `google-services.json` → place in `android/app/`
4. Download `GoogleService-Info.plist` → place in `ios/Runner/`
5. Run FlutterFire CLI to generate `lib/firebase_options.dart`:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

6. Enable **Email/Password** authentication in Firebase Console → Authentication → Sign-in methods
7. Create a **Firestore** database and set up your programs collection

### 4. AdMob setup (optional)

- Replace ad unit IDs in `lib/core/services/ad_manger.dart` with your own
- For testing, set `isTest = true` in `AdManger` to use Google test ad IDs

### 5. Run the app

```bash
flutter run
```

---

## 🔄 CI/CD Pipeline

EgyAssist uses **Codemagic** for automated builds and deployments, connected to this GitHub repository.

| Trigger | Action |
|---------|--------|
| Push to `main` | Build Android AAB (release, signed) |
| Push to `main` | Build iOS IPA (release, signed) |
| Manual trigger | Deploy to Google Play / App Store |

**Secrets managed in Codemagic:**
- `google-services.json` (base64 encoded)
- `GoogleService-Info.plist` (base64 encoded)
- `firebase_options.dart`
- Android release keystore + passwords
- iOS distribution certificate + provisioning profile

---

## 📦 Key Dependencies

```yaml
firebase_core: ^4.x          # Firebase initialization
firebase_auth: ^6.x          # Email/password auth
cloud_firestore: ^6.x        # Realtime database
flutter_bloc: ^9.x           # Cubit / BLoC state management
flutter_riverpod: ^3.x       # Theme and locale global state
shared_preferences: ^2.x     # Local cache (guest mode, theme, language, uId)
google_mobile_ads: ^6.x      # Banner and interstitial ads
onesignal_flutter: ^5.x      # Push notifications
persistent_bottom_nav_bar: ^6.x  # Bottom navigation
connectivity_plus: ^7.x      # Offline detection
flutter_localizations:         # EN + AR localization
```

---

## 🌐 Localization

The app supports **English** and **Arabic (RTL)** fully. All strings are managed via Flutter's ARB system:

```
lib/l10n/
├── app_en.arb       # English strings
├── app_ar.arb       # Arabic strings
└── app_localizations.dart  # Generated (do not edit manually)
```

To add a new string:
1. Add the key/value to both `app_en.arb` and `app_ar.arb`
2. Run `flutter gen-l10n`
3. Use `AppLocalizations.of(context)!.yourKey` in the widget

---

## 🔒 Guest Mode

Users can enter the app without creating an account by tapping **"Continue as a Guest"**.

- Guest state is persisted via `CacheKeys.isGuestMode` (SharedPreferences)
- Restricted sections (Profile, Bookmarks, Saved Programs, User Info) show a **blur overlay** with a "You must create an account to access this section" message and Sign In / Create Account buttons
- On successful sign-in or registration, the guest flag is cleared and full access is restored
- The root navigator is used for navigation from the overlay to avoid conflicts with the nested tab navigator

---

## 📋 Project Phases

| Phase | What was built |
|-------|---------------|
| **1 – Concept & Data** | Problem identified; CSV data compiled with real European programs; data migrated to Firestore |
| **2 – Core App** | Clean Architecture scaffold; Firebase Auth; Onboarding; Sign In / Sign Up; Home screen |
| **3 – Search & Filter** | Full-text search; Smart filter (country, field, language, MOI); Program details with AdMob banner |
| **4 – Favorites** | Firestore-backed bookmarks; Saved programs on Home; Favourite screen |
| **5 – Profile & Settings** | Edit profile; Avatar selection; Change password; Delete account; Theme toggle; Language toggle |
| **6 – Localization** | Full EN/AR ARB localization; RTL layout support; Country guides translated |
| **7 – Country Guides** | Germany, Austria, and other European country detail screens with requirements, steps, and links |
| **8 – Help & Support** | About Us, Privacy Policy, Terms & Conditions; App version display |
| **9 – Guest Mode** | Guest flag in cache; Blur overlays on restricted sections; Root navigator fix for nested tabs |
| **10 – Validation** | Email format validation; Password strength requirements with live UI checklist |
| **11 – Deployment Prep** | Application ID (`com.egyassist.app`); MobileAds init; iOS AdMob config; Codemagic CI/CD setup; Pre-deployment test plan |

---

## 🤝 Contributing

This project is part of a personal portfolio. If you find a bug or have a suggestion, feel free to open an issue.

---

## 📄 License

This project is for personal and portfolio use. All rights reserved.

---

<div align="center">

**Built with ❤️ to help Egyptian students find their path to European universities.**

*If this project helped you or inspired you, consider giving it a ⭐*

</div>
