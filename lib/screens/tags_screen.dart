import 'package:flutter/material.dart';
import '../models/tag.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  List<Tag> tags = [
    Tag(id: '1', name: 'Cibo', color: '#FF5722'),
    Tag(id: '2', name: 'Trasporto', color: '#4CAF50'),
    Tag(id: '3', name: 'Divertimento', color: '#2196F3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestione Tags'),
      ),
      body: ListView.builder(
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final tag = tags[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(int.parse(tag.color.substring(1), radix: 16)),
                  shape: BoxShape.circle,
                ),
              ),
              title: Text(tag.name),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    tags.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTag,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTag() {
    // Implementazione per aggiungere un nuovo tag
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Aggiungi Tag'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nome Tag'),
            ),
            DropdownButton<String>(
              items: [
                DropdownMenuItem(value: '#FF5722', child: Text('Arancione')),
                DropdownMenuItem(value: '#4CAF50', child: Text('Verde')),
                DropdownMenuItem(value: '#2196F3', child: Text('Blu')),
                DropdownMenuItem(value: '#9C27B0', child: Text('Viola')),
              ],
              onChanged: (value) {
                // Gestione selezione colore
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