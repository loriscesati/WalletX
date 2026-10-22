# WalletX Technical Guide for LLMs

## Architecture
- **Type**: Progressive Web App (PWA) designed for high performance and offline capabilities.
- **Frontend**: Vanilla JavaScript (ES6+) utilizing modern web APIs, HTML5, and CSS3 for a lightweight, dependency-free UI.
- **Backend/BaaS**: Firebase ecosystem:
    - **Firestore**: NoSQL document database for real-time data synchronization.
    - **Firebase Authentication**: Secure user management and session handling.
    - **Firebase Hosting**: Fast and secure deployment of static assets.
- **State Management**: Reactive state pattern using Firestore listeners (`on_snapshot`) and local JavaScript module states to ensure UI consistency with the backend.

## Feature Structure
- **Authentication Module**: Handles user registration, login, and password recovery via Firebase Auth.
- **Dashboard**: The central hub providing an aggregate view of:
    - Total balance across all wallets.
    - Recent transaction summaries.
    - Quick action buttons for common tasks.
- **Transactions Module**: A robust system for viewing, searching, and filtering financial history.
    - Includes detailed views for each transaction (sender, receiver, amount, timestamp, category).
- **Wallet Management**: Allows users to create, edit, and delete multiple currency-specific wallets.
- **Settings & Profile**: Manages user preferences, theme settings (Light/Dark), and account details.

## Data Management Logic
- **Data Model**:
    - `users/{userId}`: Contains user metadata, settings, and configuration.
    - `wallets/{walletId}`: Stores wallet-specific information (name, currency code, balance).
    - `transactions/{transactionId}`: Represents individual movements of funds, linked to a specific `walletId` and `userId`.
- **Consistency**: All writes are performed via Firebase SDK. Real-time updates are propagated to the client through Firestore snapshots, minimizing manual refreshes.
- **Offline Support**: Implementation of Service Workers to cache critical assets (HTML, JS, CSS) and provide a functional offline experience using IndexedDB/Firestore persistence.

## Placeholders to Implement
- [ ] **Auth Flow Completion**: Full integration of Social Login (Google/Apple) alongside Email/password.
- [ ] **Dynamic Charting**: Integration of a charting library (e.g., Chart.js) on the Dashboard to visualize balance trends over time.
- [ ] **Transaction Form**: A complete, validated UI component for creating new transactions with category selection.
- [ ] **Advanced Filtering**: Implementation of complex query logic for filtering transactions by date ranges and custom tags.
- [ ] **Push Notifications**: Integration with Firebase Cloud Messaging (FCM) for transaction alerts and reminders.
