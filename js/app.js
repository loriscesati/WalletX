import { getYearMonth } from './utils.js';
import { dataService, authService } from './firebase.js';

class App {
  constructor() {
    this.user = null;
    /* Auth listener */
    authService.onAuthStateChanged(user => {
      if (user) {
        this.user = user;
        this.loadDashboard();
      } else {
        console.log('No authenticated user');
        this.showLoginScreen();
      }
    });
  }

  showLoginScreen() {
    const appDiv = document.getElementById('app');
    appDiv.innerHTML = `
      <div class="card">
        <h1>WalletX PWA</h1>
        <p>Welcome to your personal finance manager</p>
        <button id="btn-auth" class="auth-button">Login with Google</button>
      </div>
    `;
    
    const loginBtn = document.getElementById('btn-auth');
    if (loginBtn) {
      loginBtn.addEventListener('click', async () => {
        await authService.loginWithGoogle();
      });
    }
  }

  async loadDashboard() {
    try {
      const tags = await dataService.getTags(this.user.uid);
      console.table(tags);
      
      // Render the dashboard
      this.renderDashboard(tags);
    } catch (error) {
      console.error('Error loading dashboard:', error);
      document.getElementById('app').innerHTML = '<p class="error">Error loading data. Please check browser console.</p>';
    }
  }

  renderDashboard(tags) {
    const appDiv = document.getElementById('app');
    
    // Create a simple dashboard UI
    let htmlContent = `
      <div class="card">
        <h1>WalletX Dashboard</h1>
        <p>Welcome, ${this.user.displayName || this.user.email}!</p>
        <button id="btn-logout" class="logout-button">Logout</button>
        
        <h2>Your Tags (${tags.length})</h2>
    `;
    
    if (tags.length === 0) {
      htmlContent += '<p>No tags found. Add some transactions!</p>';
    } else {
      // Group by month
      const grouped = {};
      for(const tag of tags){
        const key = getYearMonth(tag.createdAt.toDate());
        (grouped[key] ??= []).push(tag);
      }
      
      htmlContent += '<div class="tags-container">';
      Object.keys(grouped).sort().reverse().forEach(month => {
        htmlContent += `<h3>${month}</h3><ul>`;
        grouped[month].forEach(tag => {
          htmlContent += `<li class="tag-item"><span class="tag-name">${tag.name}</span> <span class="tag-amount">${tag.amount} EUR</span></li>`;
        });
        htmlContent += '</ul>';
      });
      htmlContent += '</div>';
    }
    
    htmlContent += '</div>';
    
    appDiv.innerHTML = htmlContent;
    
    // Add logout functionality
    const logoutBtn = document.getElementById('btn-logout');
    if (logoutBtn) {
      logoutBtn.addEventListener('click', async () => {
        await authService.logout();
      });
    }
  }
}

window.addEventListener('DOMContentLoaded', () => {
  new App();
});