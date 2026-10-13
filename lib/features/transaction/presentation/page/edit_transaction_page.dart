import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:expense_tracker/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EditTransactionPage extends StatefulWidget {
  final TransactionEntity transaction ;

  const EditTransactionPage({
    super.key,
    required this.transaction
    });

  @override
  State<EditTransactionPage> createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  TransactionEntity get transaction => widget.transaction;
  final description = TextEditingController();
  final amount = TextEditingController();
  final type = TextEditingController();

  @override
  void dispose(){
    description.dispose();
    amount.dispose();
    type.dispose();
    super.dispose();
  }

  @override 
  void initState(){
    super.initState();
    description.text = transaction.description;
    amount.text = transaction.amount.toString();
  }

  Future <void> updateTransaction() async{
    final transactionDescription = description.text.trim();
    final transactionAmount = amount.text.trim();

    if( transactionDescription.isEmpty || transactionAmount.isEmpty){
      ScaffoldMessenger.of( 
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill the fields'),));
      return;
    }
    final updateAmount = double.parse(transactionAmount) ;
    final updatedTransaction = widget.transaction.copyWith(
      description: transactionDescription,
      amount: updateAmount,
    );

    context.read<TransactionBloc>().add(UpdateTransactionEvent(updatedTransaction));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editing Transaction"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        TextField(
              controller: description,
             
              decoration: const InputDecoration(
                
                // Adds thick padding inside the input box
                contentPadding: EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 13),
            TextField(
              controller: amount,
             
              decoration: const InputDecoration(
               
                // Adds thick padding inside the input box
                contentPadding: EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 13),
          ElevatedButton(onPressed: (){
            updateTransaction();
            Navigator.pop(context);
          }, 
          child: Text('Edit'))
        ],),
    );


  }
}