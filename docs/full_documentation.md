# WalletX PWA – Complete Technical Documentation

## 1️⃣ Overview
- **Goal**: personal finance tracker, built as a vanilla‑JS Progressive Web App (PWA).
- **Auth & Data**: Firebase Auth + Firestore (v9 modular) via CDN.
- **Analytics**: Chart.js v3.
- **Architecture**: Single‑page application; navigation handled by bottom bar + side drawer; view injection performed by `js/app.js`.

## 2️⃣ Project Structure
```
walletx_pwa/
├─ css/                # styles (style.css)
├─ icons/               # PWA icon set
├─ js/
│   ├─ app.js          # SPA bootstrap & auth listener
│   ├─ firebase.js      # SDK wrappers
│   ├─ main.js          # legacy entry point (unused in current build)
│   └─ utils.js         # helper functions
├─ lib/                 # additional libs
├─ node_modules/        # runtime dependencies (firebase, vite)
├─ docs/
│   ├─ llm_context.md  # previous AI‑ready brief
│   └─ full_documentation.md
├─ index.html           # root page & service worker registration
├─ manifest.json
├─ sw.js                # service worker implementation
└─ vite.config.js      # Vite config (dev server)
```

## 3️⃣ Core Files – Functionality Snapshot

### `index.html`
| Element | Purpose |
|---------|----------|
| `<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>` | Chart.js CDN |
| Firebase SDKs (compat mode) | Auth & Firestore access |
| `<link rel="manifest" href="manifest.json">` | PWA manifest |
| `<div id="app">…</div>` | Root container for SPA |

### `js/app.js`
```js
import { getYearMonth } from './utils.js';
import { loginWithGoogle, logout, onAuthStateChanged, authService } from './firebase.js';
class App {
  constructor() { … }
  async loadDashboard() { … }
}
window.addEventListener('DOMContentLoaded', () => new App());
```
- **Entry Point**: Instantiates `App`, sets up auth listener, calls `loadDashboard` when user logged in.
- **Key Functions**:
    - `getYearMonth(date)` – used to group tags by month.

### `js/firebase.js`
```js
import { initializeApp } from 'firebase/app';
import { getAuth, onAuthStateChanged, signInWithPopup, GoogleAuthProvider, signOut } from 'firebase/auth';
import { getFirestore, collection, query, where, orderBy, getDocs, setDoc, serverTimestamp } from 'firebase/firestore';

const firebaseApp = initializeApp(firebaseConfig);
export const db = getFirestore(firebaseApp);
export const auth = getAuth(firebaseApp);
// Auth service
export const authService = {
  loginWithGoogle: async () => { … },
  logout: async () => signOut(auth),
  onAuthStateChanged: callback => onAuthStateChanged(auth, callback)
};
// Data service wrappers
export const dataService = {
  getTags: async uid => { … },
  getTransactions: async (uid, daysAgo=30) => { … },
  …
};
```
- **Auth**: `loginWithGoogle()` opens popup, `logout()`, listener.
- **Data**: CRUD wrappers over Firestore collections (`users/<uid>/tags`, `transactions`, etc.).

### `js/utils.js`
```js
export default {
  formatCurrency(amount) { … },
  formatDate(date) { … },
  getYearMonth(date) { … },
  calculateMonthlyAmortization(amount, freq) { … },
  calculatePercentageChange(cur, avg) { … },
  isPastDate(date) { … }
};
```
- **Formatting**: currency & date for Italian locale.
- **Data helpers**: month key extraction, amortization calculations.

### `js/main.js` (legacy)
- Holds older Firebase initialisation; not used in current SPA flow.

## 4️⃣ API Surface – Data Contracts
| Module | Function | Params | Returns |
|--------|----------|-------|---------|
| `dataService.getTags(uid)` | fetch tags | `uid:string` | `Tag[]` (`{id,createdAt,…}`) |
| `dataService.getTransactions(uid,d)` | transactions list | `daysAgo?=30` | `Transaction[]` |
| `authService.loginWithGoogle()` | sign‑in | – | `User` object |

## 5️⃣ Deployment & PWA Features
- **ServiceWorker (`sw.js`)**: caches static assets, handles offline support.
- **Manifest**: defines icons, theme color, start URL.
- **Vite dev**: `vite.config.js` for dev server; no bundling in production.

## 6️⃣ TODO / Future Work
- Audit Firebase security rules to enforce per‑user data isolation.
- Expand service worker caching strategy (images, fonts).
- Add unit tests for `utils.getYearMonth()` and other helpers.
- Migrate to TypeScript for static type safety.
- Refactor legacy `main.js` or remove unused code.

---
*End of file.*