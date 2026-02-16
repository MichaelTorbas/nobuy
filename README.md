# NoBuy — Quit Overspending App

A mobile app that helps users break impulse buying habits and track no-spend streaks. Think "I Am Sober but for spending addiction."

## Design

- **Dark mode** only (deep charcoal `#1A1A2E`, mint green `#00D09C`, gold `#FFD700`, coral `#FF6B6B`)
- **Onboarding**: 16 screens with progress bar, emotional hooks, quizzes, yearly waste reveal, identity shift, paywall, notification permission, then main app
- **Main app**: Home (live streak + money saved), Daily Check-In, Urge Mode, Milestones, Stats, Settings

## How to Run

1. **Open in Xcode**  
   - Open `NoBuy.xcodeproj` in Xcode (or create a new iOS App and add the `NoBuy` folder as the source).

2. **If you don’t have a project yet**  
   - File → New → Project → App  
   - Product Name: **NoBuy**, Interface: **SwiftUI**, Language: **Swift**  
   - Add all `.swift` files from the `NoBuy` folder to the app target (drag the `NoBuy` group in).

3. **Build and run** on a simulator or device (iOS 17+).

## Project Structure

```
NoBuy/
├── NoBuyApp.swift              # @main entry
├── RootView.swift              # Onboarding vs Paywall vs Main
├── Theme/NoBuyTheme.swift      # Colors, typography, layout
├── Models/
│   ├── UserProfile.swift      # Onboarding & settings data
│   └── StreakState.swift      # Streak, check-ins, slips
├── Services/DataStore.swift   # UserDefaults persistence
├── Utilities/HapticManager.swift
├── Onboarding/
│   ├── OnboardingContainerView.swift  # 16-screen flow + progress bar
│   └── Screens/*.swift         # All onboarding screens + PaywallView
├── Views/ConfettiView.swift
└── Main/
    ├── MainTabView.swift
    ├── Home/HomeView.swift    # Streak counter, pledge, check-in, urge button
    ├── CheckIn/DailyCheckInSheet.swift
    ├── Urge/UrgeModeView.swift
    ├── Milestones/MilestonesView.swift
    ├── Stats/StatsView.swift
    └── Settings/SettingsView.swift
```

## Features

- **Live streak counter** (days : hours : minutes : seconds) with 1s updates
- **Money saved** from estimated daily waste rate
- **Daily Check-In** (morning pledge / evening “did you impulse buy?” + trigger + mood)
- **Urge Mode**: 4-7-8 breathing, then decision questions, then “I Resisted” / “I bought it”
- **Milestones**: 1, 3, 7, 14, 30, 60, 90 days, 6 months, 1 year (locked/unlocked, share placeholder)
- **Stats**: total saved, current/longest streak, urges resisted, check-ins (chart placeholders)
- **Settings**: edit habits, pledge, vision, check-in times, notifications, subscription, support links

## Integrations (placeholders)

- **Paywall**: Screen and flow in place; wire to Superwall or RevenueCat.
- **Analytics**: Add Firebase Analytics (or your provider) where needed.
- **Crashlytics**: Add Firebase Crashlytics (or your provider).
- **Notifications**: Permission requested in onboarding; schedule morning/evening reminders with `UNUserNotificationCenter`.

## Data

- All data is stored locally with **UserDefaults** (profile + streak state).
- No backend required for V1.

## License

Use as you like for your project.
