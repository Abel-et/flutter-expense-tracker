import 'package:hive/hive.dart';
import '../model/transaction_model.dart';
import 'local_data_source.dart';
import 'package:flutter/foundation.dart';

class LocalDataSourceImpl implements LocalDataSource{
  final Box<TransactionModel> transactionBox ;

  LocalDataSourceImpl({
    required this.transactionBox
    });

 @override
Future<List<TransactionModel>> getAllTransaction() async {
  debugPrint('LOCAL DATA SOURCE: GETTING ALL TRANSACTIONS');

  final transactions = transactionBox.values.toList();

  debugPrint(
    'LOCAL DATA SOURCE: FOUND ${transactions.length} TRANSACTIONS',
  );

  return transactions;
}

  @override
  Future<TransactionModel> getTransaction(int id) async{
    final  transaction = transactionBox.get(id);
    if(transaction == null){
      throw Exception('Transaction Id not found in local cache');
    }

    return transaction;
  }

@override
Future<void> saveTransaction(TransactionModel transaction) async {
  debugPrint('LOCAL DATA SOURCE: SAVING TRANSACTION');
  debugPrint('ID: ${transaction.id}');
  debugPrint('AMOUNT: ${transaction.amount}');
  debugPrint('TYPE: ${transaction.type}');

  await transactionBox.put(
    transaction.id,
    transaction,
  );

  debugPrint('LOCAL DATA SOURCE: SAVE SUCCESS');
}

  @override 
  Future<void> deleteTransaction(int id ) async{
    if(!transactionBox.containsKey(id)){
      throw Exception('Cannot delete Transaction id is not exist');
    }
    await transactionBox.delete(id);
    
  }
}