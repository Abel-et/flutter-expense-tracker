// import 'package:expense_tracker/features/transaction/data/datasource/local_data_source.dart';
// import 'package:expense_tracker/core/utility/net_worth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/transaction/presentation/bloc/transaction_bloc.dart';
import 'features/transaction/presentation/bloc/transaction_event.dart';
import 'features/transaction/presentation/page/home_page.dart';
import 'features/transaction/data/datasource/local_data_source_impl.dart';
import 'features/transaction/data/repository/transaction_repository_impl.dart';
import 'features/transaction/domain/useCase/transaction_use_case.dart';
import 'features/transaction/data/model/transaction_model.dart';
// import 'features/transaction/data/model/transaction_model.g.dart';

// the composition roots 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  
  final transactionBox = await Hive.openBox<TransactionModel>('transaction_box');
  final localDataSource = LocalDataSourceImpl(
    transactionBox : transactionBox
    );
  final repository = TransactionRepositoryImpl(localDataSource);
 
  final testTransaction = TransactionModel(
  id: 999,
  amount: 100.0,
  type: 'income',
  date: DateTime.now(),
  description: 'Test transaction',
);

await transactionBox.put(
  testTransaction.id,
  testTransaction,
);

debugPrint('HIVE TEST SUCCESS');

  runApp(  
    MultiBlocProvider(
      providers: [
        BlocProvider<TransactionBloc>(  
          create:(context) => TransactionBloc( 
            // these are actions that the application want to perform 
            getAllTransactionUseCase: GetAllTransactionUseCase(repository),
            getTransactionUseCase:    GetTransactionUseCase(repository),
            createTransactionUseCase: CreateTransactionUseCase(repository),
            updateTransactionUseCase: UpdateTransactionUseCase(repository),
            deleteTransactionUseCase: DeleteTransactionUseCase(repository),
          
          )..add(GetAllTransactionEvent()),
        ),
        BlocProvider<NetWrothBloc>(  
          create:(context) => NetWrothBloc(
            getNetWorthUseCase: GetNetWorthUseCase(repository))..add(GetNetWorthEvent())
        )
      ], child: const ExpenseTracker(),),
  );

}

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: TransactionListPage(
      ),
    );
  }
}

