/**
 * WalletX Application Orchestrator
 */

import { authService, dataService } from './firebase.js';
import * as utils from './utils.js';

class App {
    constructor() {
        this.user = null;
        this.init();
    }

    async init() {
        console.log('WalletX Initializing...');
        
        // Initialize Firebase Auth listener
        authService.onAuthStateChanged(async (user) => {
            if (user) {
                this.user = user;
                console.log(`User authenticated: ${user.email}`);
                await this.loadDashboard();
            } else {
                console.log('No user authenticated. Please login.');
                // In a real app, we would redirect to login page here.
            }
        });
    }

    async loadDashboard() {
        try {
            console.log('Loading dashboard data...');
            // This is where the views will be triggered
            // For now, just a placeholder
            const tags = await dataService.getTags(this.user.uid);
            console.log(`Loaded ${tags.length} tags.`);
        } catch (error) {
            console.error('Error loading dashboard:', error);
        }
    }
}

// Start the application
window.addEventListener('DOMContentLoaded', () => {
    new App();
});
