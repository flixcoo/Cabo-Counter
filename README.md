# CABO Counter

![Version](https://img.shields.io/badge/Version-0.6.2-orange)
![Flutter](https://img.shields.io/badge/Flutter-3.32.1-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1-blue?logo=dart)
![iOS](https://img.shields.io/badge/iOS-18.5-white?logo=apple)
![GitHub Last Commit](https://img.shields.io/github/last-commit/flixcoo/Cabo-Counter?logo=github) 

Cabo Counter is a Flutter-based mobile app for automated score tracking in the card game CABO. It helps players effortlessly manage scores and automatically calculate round results.

🔗 App Store: [Cabo Counter on Apple App Store]() `//todo`

## ✨ Features

- 👥 Support for 2-5 players
- ⚖️ Two game modes: 
  - **Point Limit Mode**: Play until a certain point limit is reached
  - **Unlimited Mode**: Play without an limit and end the round at any point
- 🔢 Automatic score calculation with:
  - Falsly calling Cabo
  - Exact 100-point bonus (score halving)
  - Kamikaze rule handling
- 📊 Round history tracking via graph and table
- 🎨 Customizable
  - Change the default settings for point limits and cabo penaltys
  - Choose a default game mode for every new created game
- 💿 Im- and exporting certain games or the whole app data

The complete rules of the game are also available in the repository wiki at [Cabo Rules (English)](https://github.com/flixcoo/cabo-counter/wiki/CABO-Rules-(English))

## 🚀 Getting Started

### Prerequisites
- Flutter 3.32.1+
- Dart 3.8.1+
- Xcode (for iOS builds)

### Installation

```bash
git clone https://github.com/flixcoo/cabo-counter.git
cd cabo-counter
flutter pub get
flutter run
```

## 🤝 Contributing

Contributions are welcome! If you'd like to improve Cabo Counter, please:
- Follow the existing code style and architecture
- Maintain clean, well-documented code
- Keep changes focused and test your work

Feel free to open issues or submit pull requests!

## ⚠️ Disclaimer

This project is not affiliated with or endorsed by Smiling Monster GmbH. CABO is a registered trademark of its respective owners. This app is designed for scorekeeping purposes only and does not include actual game components.

---

> 🚀 Powered by Flutter | Developed with 🩵
