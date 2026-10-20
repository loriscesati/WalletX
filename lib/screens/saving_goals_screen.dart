import 'package:flutter/material.dart';

class SavingsGoalsScreen extends StatefulWidget {
  const SavingsGoalsScreen({super.key});

  @override
  State<SavingsGoalsScreen> createState() => _SavingsGoalsScreenState();
}

class _SavingsGoalsScreenState extends State<SavingsGoalsScreen> {
  List<Map<String, dynamic>> goals = [
    {
      'id': '1',
      'name': 'Vacanza Estiva',
      'targetAmount': 1500.0,
      'currentAmount': 800.0,
      'deadline': DateTime(2024, 7, 31),
    },
    {
      'id': '2',
      'name': 'Nuovo Smartphone',
      'targetAmount': 800.0,
      'currentAmount': 250.0,
      'deadline': DateTime(2024, 12, 31),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obiettivi di Risparmio'),
      ),
      body: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          final goal = goals[index];
          double progress = (goal['currentAmount'] / goal['targetAmount']) * 100;
          
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(goal['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress / 100,
                    minHeight: 10,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${goal['currentAmount'].toStringAsFixed(2)} / \$${goal['targetAmount'].toStringAsFixed(2)}'),
                      Text('${progress.toStringAsFixed(1)}%'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Scadenza: ${goal['deadline'].day}/${goal['deadline'].month}/${goal['deadline'].year}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGoal,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addGoal() {
    // Implementazione per aggiungere un nuovo obiettivo
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Aggiungi Obiettivo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nome Obiettivo'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Importo Target'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Data Scadenza (gg/mm/aaaa)'),
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