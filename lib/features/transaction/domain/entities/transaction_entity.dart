class TransactionEntity {
  final int id;
  final double amount ;
  final String type ; // income / expense
  final DateTime date;
  final String description;

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.description
  });
}