import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';



class GetTransactionPage extends StatelessWidget {
  final TransactionEntity transaction;
  const GetTransactionPage({
    super.key,
    required this.transaction
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Transaction' ,
        style:  TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),
        textAlign: TextAlign.center,
        ),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(  
        builder: (context, state){
          if( state is TransactionLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if ( state is TransactionFailure){
            return Text('their is failure due to ${state.errorMessage}');
          }

          return Column(  
            children: [
              Text(transaction.type,
              textAlign: TextAlign.center,
              
              style: Theme.of(context).textTheme.headlineLarge
              ),
               Text(transaction.description,
               style: Theme.of(context).textTheme.headlineSmall,)
            
            ],
          );
        }),
      
    );
  }
}