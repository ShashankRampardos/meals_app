
# Meals App

Cross-platform Flutter application that lets users browse meals by category, inspect ingredients & preparation steps, apply dietary filters, and manage favourites.  
Built *hands-on* while following the “Flutter & Dart – The Complete Guide” Udemy course; every line was typed and understood rather than copy-pasted.  
The project was then refactored for clean folder layout, Provider-based state management, and production-ready build scripts.

---

## Features
- **Category grid** → drill-down into individual meals  
- **Meal detail view** with ingredients & step-by-step instructions  
- **Dietary filters** (gluten-free, lactose-free, vegetarian, vegan)  
- **Favourite toggle** stored in local state (Provider)  
- **Responsive navigation** using *Tabs* and *Drawer* widgets  

---

## Tech Stack
| Layer            | Libraries / Tools |
|------------------|-------------------|
| Core Framework   | Flutter 3, Dart 3 |
| State Management | `provider`        |
| Icons & Styling  | Material 3        |
| Build / CI       | `flutter_test`, `flutter_lints` |

---

## Architecture at a Glance
```
UI (screens & widgets)
│
├── Provider layer ── global app state (meals, favourites, filters)
│
└── Data layer ────── static dummy data (can be swapped for REST / Firebase)
```

---

## Folder Structure
```
lib/
├── data/
│   └── dummy_data.dart
├── models/
│   ├── category.dart
│   └── meal.dart
├── provider/
│   ├── favorites_provider.dart
│   ├── filters_provider.dart
│   └── meals_provider.dart
├── screens/
│   ├── categories.dart
│   ├── filters_screen.dart
│   ├── meal_detail.dart
│   ├── meals.dart
│   └── tabs.dart
├── widgets/
│   ├── category_grid_item.dart
│   ├── filter_switch_tile.dart
│   ├── main_drawer.dart
│   ├── meal_item_trait.dart
│   └── meal_item.dart
└── main.dart
```

---

## Getting Started
1. **Prerequisites**  
   - Flutter 3.x (stable)  
   - Dart 3.x SDK  
2. **Clone & Run**  
   ```bash
   git clone https://github.com/<your-user>/meals-app-flutter.git
   cd meals-app-flutter
   flutter pub get
   flutter run
   ```
3. **Tests**  
   ```bash
   flutter test
   ```

---

## Roadmap
- Persist favourites & filters with **SharedPreferences / Hive**
- Replace dummy data with **Firebase** backend
- Add **search** & **pagination**
- Integrate **dark mode** theme toggle

---

## License
This repository is released under the MIT License – see `LICENSE` for details.

---

## Acknowledgements
Project inspired by the *Meals App* section of Maximilian Schwarzmüller’s **Udemy course** “Flutter & Dart – The Complete Guide”. All enhancements, refactors, and additional features were implemented independently.git 