import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';

abstract class  TransactionState {}
abstract class NetWorthState{}
class NetWorthLoading extends NetWorthState{}
class NetWorthInitial extends NetWorthState{}
class NetWorthLoaded extends NetWorthState{
  final double total ;
  NetWorthLoaded(this.total);
}
class NetWorthFailure extends NetWorthState{
  final String errorMessage;
  NetWorthFailure( this.errorMessage);
}

class NetWorthSuccessAction extends NetWorthState{
  final String successMessage;
  NetWorthSuccessAction(this.successMessage);
}


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