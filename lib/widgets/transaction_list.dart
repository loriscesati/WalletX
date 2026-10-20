import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: transaction.isIncome 
                ? Colors.green[100] 
                : Colors.red[100],
              child: Icon(
                transaction.isIncome 
                  ? Icons.arrow_upward 
                  : Icons.arrow_downward,
                color: transaction.isIncome 
                  ? Colors.green 
                  : Colors.red,
              ),
            ),
            title: Text(transaction.description),
            subtitle: Text('${transaction.date.day}/${transaction.date.month}/${transaction.date.year}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.isIncome 
                    ? '+\$${transaction.amount.toStringAsFixed(2)}' 
                    : '-\$${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: transaction.isIncome 
                      ? Colors.green 
                      : Colors.red,
                  ),
                ),
                if (transaction.tags.isNotEmpty)
                  Text(
                    transaction.tags.join(', '),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}