# 🍔 Food Delivery App

A modern Food Delivery mobile application built with Flutter and Dart.

This project is being developed as a Flutter learning and portfolio project, focusing on clean UI, reusable widgets, state management, and a complete food ordering experience.

## 🚀 Current Version

**Version 0.4**

## ✨ Features

- 🏠 Modern Home Screen
- 🔍 Food Search
- 🍔 Food Categories
- ⭐ Food Ratings
- 📋 Food Details
- ❤️ Favorites System
- 🛒 Add to Cart
- ➕ Increase Quantity
- ➖ Decrease Quantity
- 🗑️ Remove Cart Items
- 💰 Automatic Cart Total
- 🔢 Cart Item Badge
- 🧹 Clear Cart
- 👤 Profile Screen
- 🔄 Bottom Navigation
- 📱 Clean Flutter UI
- 🎨 Reusable Custom Widgets

## 🛠️ Technologies Used

- Flutter
- Dart
- Provider
- Material Design
- VS Code
- Git
- GitHub

## 📂 Project Structure

```text
lib/
│
├── data/
│   ├── food_data.dart
│   └── recommended_food_data.dart
│
├── models/
│   └── food_model.dart
│
├── providers/
│   ├── cart_provider.dart
│   ├── favorite_provider.dart
│   └── search_provider.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── food_details_screen.dart
│   ├── cart_screen.dart
│   ├── favorites_screen.dart
│   └── profile_screen.dart
│
├── widgets/
│   ├── cart/
│   │   └── cart_item.dart
│   ├── category_list.dart
│   ├── custom_bottom_nav.dart
│   ├── food_card.dart
│   ├── header_section.dart
│   ├── hero_banner.dart
│   ├── recent_searches.dart
│   ├── recommended_food_section.dart
│   └── search_bar_widget.dart
│
├── utils/
│   └── app_theme.dart
│
└── main.dart
```

## 🏠 Home Screen

The Home Screen includes:

- Header section
- Search bar
- Hero banner
- Food categories
- Popular food section
- Recommended food section
- Bottom navigation

## 🔍 Search

Users can search for food items using the search bar.

The search system checks:

- Food name
- Food description

Search state is managed using `SearchProvider`.

## ❤️ Favorites

Users can add food items to their favorites and remove them whenever needed.

Favorites are managed using `FavoriteProvider`.

## 🛒 Cart

The cart system allows users to:

- Add food items
- Increase quantity
- Decrease quantity
- Remove individual items
- Clear the complete cart
- View total number of items
- View the total price

Cart state is managed using `CartProvider`.

## 📋 Food Details

Users can open a food item and view its:

- Name
- Image
- Price
- Rating
- Preparation time
- Description
- Calories
- Category

Users can also add the selected food to the cart.

## 👤 Profile

The current version includes a Profile Screen accessible through the bottom navigation.

## 🔄 Bottom Navigation

The application currently provides navigation for:

- 🏠 Home
- ❤️ Favorites
- 🛒 Cart
- 👤 Profile

The cart icon also displays the current number of items in the cart.

## 🧩 State Management

This project uses **Provider** for state management.

### Providers

```text
CartProvider
FavoriteProvider
SearchProvider
```

## 🎨 UI & Design

The application focuses on:

- Clean and modern UI
- Reusable widgets
- Consistent colors
- Rounded cards
- Food-focused visual design
- Simple and user-friendly navigation

## 📸 Screenshots

Screenshots of the application will be added to this section.

## 🔮 Future Plans

Future versions of the application may include:

- More food items
- More food categories
- Advanced category filtering
- Checkout system
- Order placement
- Order tracking
- User authentication
- Backend/API integration
- Improved animations
- Additional UI improvements

## 📌 Project Status

The project is actively being developed as a Flutter learning and portfolio project.

### Current Version: 0.4

The main UI, search, favorites, cart management, food details, profile, and navigation features are currently implemented.

## 👨‍💻 Developer

**M. Abdullah**

---

⭐ Thanks for checking out this project!
