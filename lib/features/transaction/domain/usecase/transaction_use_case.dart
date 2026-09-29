import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/transaction/domain/repository/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';


class GetAllTransactionUseCase {
  final TransactionRepository repository;

  GetAllTransactionUseCase(
    this.repository
  );

  Future<Either<Failure,List<TransactionEntity>>> call() async{
    return await repository.getAllTransaction();
  }
}


class GetTransactionUseCase {
  final TransactionRepository repository;
  
  GetTransactionUseCase( this.repository);

  Future<Either<Failure, TransactionEntity>> call( int id) async{
    return await repository.getTransaction(id);
  }
}


class UpdateTransactionUseCase {
  final TransactionRepository repository;
  UpdateTransactionUseCase( 
    this.repository
  );

  Future<Either< Failure,void >> call(TransactionEntity transaction) async{
    return await repository.updateTransaction(transaction);
  }
}


class CreateTransactionUseCase{
  final TransactionRepository repository;

  CreateTransactionUseCase( this.repository);
  
  Future<Either<Failure, void>> call(TransactionEntity transaction) async {
    return await repository.createTransaction(transaction);
  }
}


class DeleteTransactionUseCase{
  final TransactionRepository repository;

  DeleteTransactionUseCase(this.repository);

  Future<Either<Failure,void>> call(int id ) async{
    return await repository.deleteTransaction(id);
  }
}