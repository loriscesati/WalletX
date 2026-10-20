import 'package:flutter/material.dart';
import '../models/subscription.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  List<Subscription> subscriptions = [
    Subscription(
      id: '1',
      name: 'Abbonamento Telefonico',
      amount: 30.0,
      startDate: DateTime(2024, 1, 15),
      endDate: null,
      period: Period.monthly,
      tags: ['Telefono'],
    ),
    Subscription(
      id: '2',
      name: 'Netflix',
      amount: 15.99,
      startDate: DateTime(2024, 1, 10),
      endDate: null,
      period: Period.quarterly,
      tags: ['Divertimento'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abbonamenti'),
      ),
      body: ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final subscription = subscriptions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(subscription.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${subscription.amount.toStringAsFixed(2)}'),
                  Text('Periodo: ${_getPeriodString(subscription.period)}'),
                  if (subscription.tags.isNotEmpty)
                    Text('Tags: ${subscription.tags.join(', ')}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    subscriptions.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSubscription,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _getPeriodString(Period period) {
    switch (period) {
      case Period.monthly:
        return 'Mensile';
      case Period.quarterly:
        return 'Trimestrale';
      case Period.annual:
        return 'Annuale';
      default:
        return '';
    }
  }

  void _addSubscription() {
    // Implementazione per aggiungere un nuovo abbonamento
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Aggiungi Abbonamento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nome Abbonamento'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Importo'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<Period>(
              items: [
                DropdownMenuItem(value: Period.monthly, child: Text('Mensile')),
                DropdownMenuItem(value: Period.quarterly, child: Text('Trimestrale')),
                DropdownMenuItem(value: Period.annual, child: Text('Annuale')),
              ],
              onChanged: (value) {
                // Gestione selezione periodo
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
  }
}

enum Period { monthly, quarterly, annual }