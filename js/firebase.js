// WalletX Firebase Data Access Layer (DAL) – modular SDK version

import { initializeApp } from 'firebase/app';
import { getAuth, signInWithPopup, GoogleAuthProvider, signOut, onAuthStateChanged } from 'firebase/auth';
import { getFirestore, collection, getDocs } from 'firebase/firestore';
import { firebaseConfig } from './config.js';

// Initialize Firebase immediately – errors will surface at import time if config is wrong
const firebaseApp = initializeApp(firebaseConfig);
const auth = getAuth(firebaseApp);
const db = getFirestore(firebaseApp);

/* ------------- Auth helpers ----------------------------------- */
export const getCurrentUser = () => auth?.currentUser;

export const authService = {
  getCurrentUser: () => auth?.currentUser,
  async loginWithGoogle() {
    console.log('Attempting Google login...');
    const provider = new GoogleAuthProvider();
    return signInWithPopup(auth, provider);
  },
  async logout() {
    console.log('Logging out user...');
    return signOut(auth);
  },
  onAuthStateChanged(cb) {
    console.log('Setting up auth state listener');
    return onAuthStateChanged(auth, cb);
  }
};

/* ------------- Firestore helpers ----------------------------------- */
export const dataService = {
  async getTags(userId) {
    console.log('Fetching tags for user:', userId);
    const ref = collection(db, 'users', userId, 'tags');
    const snap = await getDocs(ref);
    console.log('Retrieved tags count:', snap.docs.length);
    return snap.docs.map(d => d.data());
  }
};
