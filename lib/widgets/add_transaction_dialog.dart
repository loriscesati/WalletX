import 'package:flutter/material.dart';
import '../models/transaction.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function(Transaction) onAdd;

  const AddTransactionDialog({super.key, required this.onAdd});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final List<String> _tags = [];
  bool _isIncome = false;
  
  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Aggiungi Transazione'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _isIncome,
                    onChanged: (value) {
                      setState(() {
                        _isIncome = value!;
                      });
                    },
                  ),
                  const Text('Entrata'),
                  Radio<bool>(
                    value: false,
                    groupValue: _isIncome,
                    onChanged: (value) {
                      setState(() {
                        _isIncome = value!;
                      });
                    },
                  ),
                  const Text('Uscita'),
                ],
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrizione'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci una descrizione';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Importo'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci un importo';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Inserisci un numero valido';
                  }
                  return null;
                },
              ),
              Wrap(
                spacing: 4,
                children: [
                  const Text('Tags:'),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implementazione per aggiungere tag
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Aggiungi Tag'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final amount = double.parse(_amountController.text);
              final transaction = Transaction(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                description: _descriptionController.text,
                amount: amount,
                date: DateTime.now(),
                isIncome: _isIncome,
                tags: _tags, // Tag da implementare
              );
              widget.onAdd(transaction);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Aggiungi'),
        ),
      ],
    );
  }
}