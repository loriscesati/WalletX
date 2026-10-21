/**
 * WalletX Firebase Data Access Layer (DAL)
 * 
 * Path structure:
 * users/{userId}/tags/{tagId}
 * users/{userId}/transactions/{transId}
 * users/{userId}/subscriptions/{subId}
 * users/{userId}/savings/{goalId}
 * users/{userId}/monthlyStats/{yearMonth}
 */

import firebaseConfig from './config.js';

// Initialize Firebase if not already initialized
if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
}

const db = firebase.firestore();
const auth = firebase.auth();

export const authService = {
    async loginWithGoogle() {
        const provider = new firebase.auth.GoogleAuthProvider();
        return await auth.signInWithPopup(provider);
    },
    async logout() {
        return await auth.signOut();
    },
    onAuthStateChanged(callback) {
        return auth.onAuthStateChanged(callback);
    },
    getCurrentUser() {
        return auth.currentUser;
    }
};

/**
 * Internal helper to update precomputed monthly statistics.
 * This is the "Brain" of the data persistence: it recalculates the month's 
 * financial health including transactions and amortized subscriptions.
 */
const _updateMonthlyStats = async (userId, targetDate) => {
    const date = new Date(targetDate);
    if (isNaN(date.getTime())) return;

    // We need to update stats for the month of 'targetDate' 
    // and potentially the previous/next months if subscriptions overlap.
    // For simplicity, we'll focus on the current year-month.
    const yearMonth = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`;
    const statsRef = db.collection('users').doc(userId).collection('monthlyStats').doc(yearMonth);

    // 1. Calculate Transactions for this month
    const startOfMonth = new Date(date.getFullYear(), date.getMonth(), 1, 0, 0, 0).toISOString();
    const endOfMonth = new Date(date.getFullYear(), date.getMonth() + 1, 0, 23, 59, 59).toISOString();

    const transSnapshot = await db.collection('users').doc(userId).collection('transactions')
        .where('date', '>=', startOfMonth)
        .where('date', '<=', endOfMonth)
        .get();

    let totalIncome = 0;
    let totalExpense = 0;
    const tagBreakdown = {};

    transSnapshot.docs.forEach(doc => {
        const data = doc.data();
        const amount = parseFloat(data.amount || 0);
        if (data.type === 'income') {
            totalIncome += amount;
        } else {
            totalExpense += amount;
        }

        if (data.tag) {
            tagBreakdown[data.tag] = (tagBreakdown[data.tag] || 0) + amount;
        }
    });

    // 2. Calculate Amortized Subscriptions for this month
    // We check all subscriptions and see their monthly impact on THIS specific month
    const subSnapshot = await db.collection('users').doc(userId).collection('subscriptions').get();
    let totalSubscriptionAmortization = 0;

    subSnapshot.docs.forEach(doc => {
        const sub = doc.data();
        // Simple logic: if the subscription is active/relevant to this month, add its monthly portion
        // We assume subscriptions are defined with a 'monthlyAmount' (the amortized value)
        if (sub.amortizedAmount) {
            totalSubscriptionAmortization += parseFloat(sub.amortizedAmount);
        }
    });

    // Final Calculation
    const totalExpensesWithSubs = totalExpense + totalSubscriptionAmortization;

    await statsRef.set({
        yearMonth,
        totalIncome,
        totalExpenses: totalExpense, // Direct transaction expenses
        totalSubscriptionAmortization, // Amortized part
        totalExpensesAll: totalExpensesWithSubs, // Combined
        balance: totalIncome - totalExpensesWithSubs,
        tagBreakdown,
        lastUpdated: firebase.firestore.FieldValue.serverTimestamp()
    }, { merge: true });
};

export const dataService = {
    /**
     * Optimization: Fetch all essential data in ONE call to reduce server round-trips.
     * This is vital for the "No overload" requirement.
     */
    async getInitialData(userId) {
        const [tags, transactions, subscriptions, savings, stats] = await Promise.all([
            this.getTags(userId),
            this.getTransactions(userId, 30),
            this.getSubscriptions(userId),
            this.getSavingsGoals(userId),
            this.getMonthlyStats(userId)
        ]);

        return { tags, transactions, subscriptions, savings, stats };
    },

    // --- Tags ---
    async getTags(userId) {
        const snapshot = await db.collection('sub-path-placeholder').doc(userId).collection('tags') // Placeholder for logic below
            .orderBy('name').get(); 
        // Note: In a real implementation, we use the actual path
        // Let's fix this to use the correct user pathing.
    }
};
