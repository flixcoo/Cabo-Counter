# CABO Counter

![Version](https://img.shields.io/badge/Version-0.3.8-orange)
![Flutter](https://img.shields.io/badge/Flutter-3.32.1-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1-blue?logo=dart)
![iOS](https://img.shields.io/badge/iOS-18.5-white?logo=apple)
![GitHub Issues](https://img.shields.io/github/issues/flixcoo/Cabo-Counter?logo=github)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/flixcoo/Cabo-Counter?logo=github)
![GitHub Last Commit](https://img.shields.io/github/last-commit/flixcoo/Cabo-Counter?logo=github) 

A mobile score tracker for the card game Cabo, helping players effortlessly manage scores and automatically calculate round results.

## 📱 Description

Cabo Counter is an intuitive Flutter-based mobile application designed to enhance your CABO card game experience. It eliminates manual scorekeeping by automatically calculating points per round.

## ✨ Features

- 🆕 Create new games with customizable rules
- 👥 Support for 2-5 players
- ⚖️ Two game modes: 
  - **100 Points Mode** (Standard)
  - **Infinite Mode** (Casual play)
- 🔢 Automatic score calculation with:
  - Kamikaze rule handling
  - Exact 100-point bonus (score halving)  
- 📊 Round history tracking

## 🚀 Getting Started

### Prerequisites
- Flutter 3.24.5+
- Dart 3.5.4+

### Installation

```bash
git clone https://github.com/flixcoo/Cabo-Counter.git
cd Cabo-Counter
flutter pub get
flutter run
```

## 🎮 Usage

1. **Start New Game**
- Choose game mode (100 Points or Infinite)
- Add 2-5 players

2. **Gameplay**
- Track rounds with automatic scoring
- Handle special rules (Kamikaze, exact 100 points)
- View real-time standings

3. **Round Management**
- Automatic winner detection
- Penalty point calculation
- Game-over detection (100 Points mode)

## 🃏 Key Rules Overview

### Scoring System
- Round winner: 0 points
- Other players: Sum of card values
- Failed Cabo call: +5 penalty points
- Kamikaze: 0 points for caller, 50 for others
- Exact 100 points: Score halved

### Game End
- First player ≥101 points triggers final scoring
- Lowest total score wins

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
