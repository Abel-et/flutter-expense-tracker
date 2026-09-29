import 'package:expense_tracker/features/transaction/data/datasource/local_data_source.dart';
import 'package:expense_tracker/features/transaction/data/model/transaction_model.dart';
import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/transaction/domain/repository/transaction_repository.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter/foundation.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final LocalDataSource localDataSource;

  TransactionRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<TransactionEntity>>>
      getAllTransaction() async {
    try {
      final models = await localDataSource.getAllTransaction();

      final transactions = models
          .map((model) => model.toEntity())
          .toList();

      return Right(transactions);
    } catch (e) {
      return Left(
        CacheFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>>
      getTransaction(int id) async {
    try {
      final model = await localDataSource.getTransaction(id);

      return Right(model.toEntity());
    } catch (e) {
      return Left(
        CacheFailure(message: e.toString()),
      );
    }
  }

  @override
Future<Either<Failure, void>> createTransaction(
  TransactionEntity transaction,
) async {
  try {
    debugPrint('CREATE START');
    debugPrint('id: ${transaction.id}');
    debugPrint('amount: ${transaction.amount}');
    debugPrint('type: ${transaction.type}');
    debugPrint('date: ${transaction.date}');
    debugPrint('description: ${transaction.description}');

    final model = TransactionModel.fromEntity(transaction);

    debugPrint('MODEL CREATED');

    await localDataSource.saveTransaction(model);

    debugPrint('HIVE SAVE SUCCESS');

    return const Right(null);
  } catch (e, stackTrace) {
    debugPrint('CREATE TRANSACTION ERROR: $e');
    debugPrint('STACK TRACE: $stackTrace');

    return Left(
      CacheFailure(
        message: e.toString(),
      ),
    );
  }
}

  @override
  Future<Either<Failure, void>>
      updateTransaction(TransactionEntity transaction) async {
    try {
      final model = TransactionModel.fromEntity(transaction);

      await localDataSource.saveTransaction(model);

      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>>
      deleteTransaction(int id) async {
    try {
      await localDataSource.deleteTransaction(id);

      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(message: e.toString()),
      );
    }
  }
}