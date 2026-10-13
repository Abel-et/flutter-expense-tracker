class TransactionEntity {
  final int id;
  final double amount ;
  final String type ; // income / expense
  final DateTime date;
  final String description;
  // final List<String> category; 

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    // required this.category,
    required this.description
  });

  TransactionEntity copyWith({
    String? description,
    double ? amount,
    String ? type,

  }) {
    return TransactionEntity(id: id,
     amount: amount ?? this.amount,
      type: type ?? this.type, 
      date: date,
     description: description ?? this.description
     );
  }
}


