/**
 * WalletX - Utility Functions
 */

export const utils = {
    // Formatta i numeri in valuta Euro (es: 1250.5 -> € 1.250,50)
    formatCurrency: (amount) => {
        return new Intl.NumberFormat('it-IT', {
            style: 'currency',
            currency: 'EUR'
        }).format(amount);
    },

    // Formatta una data in formato leggibile (es: 20/10/2023)
    formatDate: (date) => {
        const d = new Date(date);
        return d.toLocaleDateString('it-IT');
    },

    // Restituisce una stringa "YYYY-MM" per raggruppamento mensile (es: "2023-10")
    getYearMonth: (date) => {
        const d = new Date(date);
        const year = d.getFullYear();
        const month = String(d.getMonth() + 1).padStart(2, '0');
        return `${year}-${month}`;
    },

    // Calcola l'ammortamento mensile di una spesa periodica
    // frequency: 'monthly', 'quarterly', 'yearly'
    calculateMonthlyAmortization: (amount, frequency) => {
        switch (frequency) {
            case 'monthly':
                return amount;
            case 'quarterly':
                return amount / 3;
            case 'yearly':
                return amount / 12;
            default:
                return amount;
        }
    },

    // Calcola la variazione percentuale tra due valori (es per i grafici di scostamento)
    calculatePercentageChange: (current, average) => {
        if (!average || average === 0) return 0;
        return ((current - average) / average) * 100;
    },

    // Verifica se una data è nel passato o presente
    isPastDate: (date) => {
        return new Date(date) < new Date();
    }
};
