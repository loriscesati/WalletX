class Subscription {
  final String id;
  final String name;
  final double amount;
  final DateTime startDate;
  final DateTime? endDate;
  final Period period;
  final List<String> tags;

  Subscription({
    required this.id,
    required this.name,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.period,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'period': _periodToString(period),
      'tags': tags,
    };
  }

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'] as String,
      name: map['name'] as String,
      amount: map['amount'] as double,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: map['endDate'] != null 
        ? DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int) 
        : null,
      period: _stringToPeriod(map['period'] as String),
      tags: List<String>.from(map['tags'] as List<dynamic>),
    );
  }

  static String _periodToString(Period period) {
    switch (period) {
      case Period.monthly:
        return 'monthly';
      case Period.quarterly:
        return 'quarterly';
      case Period.annual:
        return 'annual';
    }
  }

  static Period _stringToPeriod(String periodStr) {
    switch (periodStr) {
      case 'monthly':
        return Period.monthly;
      case 'quarterly':
        return Period.quarterly;
      case 'annual':
        return Period.annual;
    }
  }
}

enum Period { monthly, quarterly, annual }