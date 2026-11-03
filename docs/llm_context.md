# WalletX PWA – AI‑Ready Technical Brief

## Scope & Stack
- **Lang**: vanilla ES‑Modules (Vite build step)
- **Runtime**: ServiceWorker + Chart.js v3, Firebase v9 (Auth + Firestore) via local NPM dependencies.
- **Entry**: `js/app.js` mounts SPA into `<view-container>`; navigation via bottom nav & drawer.

## Core Features (API surface)
| Feature | Key Endpoints / Modules | Data Shape |
|---------|---------------------|-------------|
| Dashboard | `dataService.getMonthlyStats(userId)` | `{date, balances, tags}` |
| Transactions | `dataService.getTransactions(userId, daysAgo?)` | `{id,date,value,tag}` |
| Subscriptions | `dataService.getSubscriptions(userId)` | `{id,start,end,amount}` |
| Savings Goals | `dataService.getSavingsGoals(userId)` | `{goalId,target,current,frequency}` |

## Core Modules
- **firebase.js** – wraps modular SDK: `authService`, `dataService`.
  ```js
  // authService.loginWithGoogle() → Promise<user>
  // dataService.getTags(uid) → Array<Tag>
  ```
- **app.js** – init, auth listener, view loader.
- **utils.js** – helpers: `formatCurrency`, `getYearMonth(date)`, `calculateMonthlyAmortization`.

## Data Flow (simplified)
1. User signs in → `authService.loginWithGoogle()`.
2. Auth state triggers → load Dashboard via `dataService.getMonthlyStats()`.
3. Render charts with Chart.js using data from Firestore snapshots.

## Deployment Notes
- PWA: service worker caches all static assets; manifest.json sets theme color & icons.
- Firebase config in `config.js` (environment‑specific). Vite build step → `vite dev`, `vite build` or serve via simple HTTP server.

## TODO
- Security rules audit.
- Comprehensive unit tests for utils.
- TypeScript migration for stricter typings.

*End of file.*