import '../model/transaction_model.dart';

abstract class LocalDataSource{
  Future<List<TransactionModel>> getAllTransaction();
  Future<TransactionModel>getTransaction(int id);
  
  // used for create and update transaction 
  Future<void> saveTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(int id);
}
