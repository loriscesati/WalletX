/**
 * WalletX - Utility Functions
 */
/**
 * WalletX - Utility Functions
 */

export function formatCurrency(amount) {
  return new Intl.NumberFormat('it-IT', {
    style: 'currency',
    currency: 'EUR'
  }).format(amount);
}

export function formatDate(date) {
  const d = new Date(date);
  return new Intl.DateTimeFormat('it-IT', { dateStyle: 'short' }).format(d);
}

export function getYearMonth(date) {
  const d = new Date(date);
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, '0');
  return `${year}-${month}`;
}

export function calculateMonthlyAmortization(amount, frequency) {
  switch (frequency) {
    case 'monthly': return amount;
    case 'quarterly': return amount / 3;
    case 'yearly': return amount / 12;
    default: return amount;
  }
}

export function calculatePercentageChange(current, average) {
  if (!average || average === 0) return 0;
  return ((current - average) / average) * 100;
}

export function isPastDate(date) {
  return new Date(date) < new Date();
}

const utils = { formatCurrency, formatDate, getYearMonth, calculateMonthlyAmortization, calculatePercentageChange, isPastDate };
export default utils;