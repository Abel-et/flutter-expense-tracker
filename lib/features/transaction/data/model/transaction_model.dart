import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';
import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.amount,
    required super.type,
    required super.date,
    required super.description,
  });

  @HiveField(0)
  @override
  int get id => super.id;

  @HiveField(1)
  @override
  double get amount => super.amount;

  @HiveField(2)
  @override
  DateTime get date => super.date;

  @HiveField(3)
  @override
  String get description => super.description;

  @HiveField(4)
  @override
  String get type => super.type;

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      amount: entity.amount,
      type: entity.type,
      date: entity.date,
      description: entity.description,
    );
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      amount: amount,
      type: type,
      date: date,
      description: description,
    );
  }
}