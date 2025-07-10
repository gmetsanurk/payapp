# PayApp

**PayApp** is a Swift 6 mobile application for monetized user interactions and purchases.

## Features

### User Selection

- **Main Screen (Feed)**  
  Displays a list of user profiles using `UICollectionView`.

- **Segmented Control**  
  Filter users by categories — Online, Popular, New, Following.

- **Profile Cards**  
  Each item shows avatar, status, and interaction buttons.

### Paywall & Subscriptions

- **Pay Screen**  
  - Page-based promo with slides  
  - Localized subscription pricing and details  

- **UIPageViewController**  
  Slide-based promotional layout

- **In-App Purchases**  
  Managed via [Adapty SDK](https://adapty.io/)

### Localization

- `.strings`-based multi-language support  
- String extension `key.localized` for lightweight usage  
- All visible UI is fully localized (tab bar, buttons, slides, alerts, etc.)

### Architecture

- **MVVM + Coordinator**  
  - `UIViewController` for views  
  - ViewModels handle formatting and logic  
  - Coordinators manage navigation

## Requirements

- iOS 15.6 or later  
- Swift 6  
- Xcode 15+

## Dependencies

- [Adapty](https://github.com/adaptyteam/AdaptySDK) — paywall & subscription handling  
- [SnapKit](https://github.com/SnapKit/SnapKit) — UI layout engine  

