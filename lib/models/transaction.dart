class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final bool isIncome;
  final List<String> tags;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'isIncome': isIncome,
      'tags': tags,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      description: map['description'] as String,
      amount: map['amount'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      isIncome: map['isIncome'] as bool,
      tags: List<String>.from(map['tags'] as List<dynamic>),
    );
  }
}