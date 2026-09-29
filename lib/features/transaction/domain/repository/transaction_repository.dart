import 'package:fpdart/fpdart.dart';
import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/core/error/failure.dart';
abstract class TransactionRepository {
  

//   create transaction 
Future<Either<Failure, void>> createTransaction(TransactionEntity transaction);

// update transaction
Future<Either<Failure, void>> updateTransaction(TransactionEntity transaction);

// get All Transactions
Future<Either<Failure, List<TransactionEntity>>> getAllTransaction();

// get single Transaction 
Future<Either<Failure, TransactionEntity>> getTransaction(int id);

// Delete Transaction 
Future<Either<Failure, void>> deleteTransaction(int id);

}