import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';

abstract class TransactionEvent {}

class GetAllTransactionEvent extends TransactionEvent{}

class AddIncomeEvent extends TransactionEvent{
  final TransactionEntity transaction ; 
  // this transaction is entity not model 
  AddIncomeEvent(this.transaction);
}
class AddExpenseEvent extends TransactionEvent{
  final TransactionEntity transaction; 
  AddExpenseEvent(this.transaction);
}
class DeleteTransactionEvent extends TransactionEvent{
  final int id;
  DeleteTransactionEvent(this.id);
}
class UpdateTransactionEvent extends TransactionEvent{
  final TransactionEntity transaction;
  UpdateTransactionEvent(this.transaction);
}

class GetTransactionEvent extends TransactionEvent{
  final int id;
  GetTransactionEvent(this.id);
}

abstract class NetWorthEvent{}
class GetNetWorthEvent extends NetWorthEvent{}