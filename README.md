# OweMe

**A simple Flutter app to track personal debts and credits.**

---

## 📋 Table of Contents

- [About the Project](#about-the-project)
- [Key Features](#key-features)
- [Screenshots & Demo](#screenshots--demo)
- [Architecture & Technologies Used](#architecture--technologies-used)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Challenges & Learning Journey](#challenges--learning-journey)
- [Current Status & Roadmap](#current-status--roadmap)
- [Contact](#contact)
- [License](#license)

---

## 🧭 About the Project

**OweMe** is a small personal project I built to practice my Flutter development skills. While I often find myself manually tracking small debts and credits between friends or family, I thought it would be a nice bonus to automate that process with an app.

The main goal of this project, though, was to explore mobile app architecture, state management, and local data persistence in a more structured and hands-on way.

It’s still in development, but it already covers the basic functionality I had in mind.

---

## ✨ Key Features

- **Manage Debtors**  
  Keep a list of people who owe you or whom you owe.

- **Log Transactions**  
  Add debts (they owe you), credits (you owe them), and payments (of their debt).

- **View Balances**  
  See the current balance for each person and a global total.

- **Transaction History**  
  View a list of all records for better tracking and accountability.

---

## 🖼️ Screenshots & Demo

> *Screenshots and demo coming soon. For now, here are a few placeholders:*

- **Dashboard View**  
  ![Dashboard Screenshot](screenshots/[add-screenshot-of-dashboard.png])

- **Add Debt Flow**  
  ![Add Debt Demo](screenshots/[add-gif-of-adding-debt.gif])

- **History List**  
  ![History Screenshot](screenshots/[add-screenshot-of-history.png])

---

## 🏗️ Architecture & Technologies Used

This app follows a Clean Architecture structure, using the following tools and technologies:

- **Architecture**: Clean Architecture (domain, data, presentation separation)
- **State Management**: BLoC Pattern
- **Local Storage**: `sqflite`
- **Dependency Injection**: `get_it`
- **Unit Testing**: `flutter_test` and `mocktail`
- **Language**: Dart
- **Framework**: Flutter

---

## 🚀 Getting Started

> If you’d like to try it out locally, here’s how:

### Prerequisites

- Flutter SDK (3.x or higher)
- Android Studio or VSCode
- A connected device or emulator

### Installation

```bash
git clone https://github.com/your-username/oweme.git
cd oweme
flutter pub get
```

### Run the App

```bash
flutter run
```

---

## 🧱 Project Structure

```bash
lib/
│
├── data/                # Repositories, models, data sources
├── domain/              # Entities, use cases, interfaces
├── presentation/        # UI code and BLoCs
├── core/                # Constants, helpers, themes
├── di/                  # Dependency injection
└── main.dart            # Entry point
```

This layout helps organize the code and keep responsibilities separate.

---

## 📚 Challenges & Learning Journey

Although I was already familiar with Clean Architecture and BLoC, this was my first time working with `sqflite` for local data persistence. I learned how to:

- Set up a local database
- Create and manage tables
- Perform CRUD operations
- Convert between domain entities and database models

It was a great learning experience and gave me more confidence working with local storage in Flutter.

---

## 🛠️ Current Status & Roadmap

### ✅ What Works:
- Adding and managing debtors
- Logging different types of transactions
- Viewing balances and transaction history

---

### 🔧 Next Steps to MVP:
- [ ] Add error handling
- [ ] Edit and delete transactions

---

### 🚀 Future Ideas:
- [ ] Add visual charts for balance trends
- [ ] Add user authentication
- [ ] Implement filters for the transaction list
- [ ] Polish the UI for better usability
- [ ] Add remote storage

---

## 👤 Contact

If you're a recruiter, developer, or just curious—thanks for checking out this project! Feel free to reach out:

**Jan Pierry**  
📧 [Your Email]  
🌐 [LinkedIn or Portfolio URL]  
📂 [GitHub Profile](https://github.com/your-username)

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).