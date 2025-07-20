# CABO Counter

![Version](https://img.shields.io/badge/Version-0.5.1-orange)
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

## 🚀 Getting Started

### Prerequisites
- Flutter 3.32.1+
- Dart 3.8.1+

### Installation

```bash
git clone https://github.com/flixcoo/Cabo-Counter.git
cd Cabo-Counter
flutter pub get
flutter run
```

## 🎮 Usage

1. **Start a new game**
- Click the "+"-Button
- Choose a game title and a game mode 
- Add 2-5 players

2. **Gameplay**
- Open the first round
- Choose the player who called Cabo
- Enter the points of every player
- If given: Choose a Kamikaze player
- Navigate to the next round or back to the overview
- Let the app calculate all points for you

3. **Statistics**
- View the progress graph for the game
- Get a detailed table overview for every points made or lost
- Game-over detection (100 Points mode)

## 🃏 Key Rules Overview

### Scoring System
- Round winner: 0 points
- Other players: Sum of card values
- Failed Cabo call: +5 penalty points
- Kamikaze: 0 points for caller, 50 for others
- Exact 100 points: Score halved

### Game End
- First player ≥100 points triggers final scoring
- In unlimited mode you can end the game via the End Game Button
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
