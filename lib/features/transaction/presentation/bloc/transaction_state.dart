import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';

abstract class  TransactionState {}

class TransactionInitial extends TransactionState{}

class TransactionLoading extends TransactionState{}


class TransactionLoaded extends TransactionState{
  final List<TransactionEntity> transactions; 
  TransactionLoaded(this.transactions);
}



class TransactionActionSuccess extends TransactionState{
  final String message;
  TransactionActionSuccess(this.message);
}

class TransactionFailure extends TransactionState{
  final String errorMessage;
  TransactionFailure(this.errorMessage);
}