import 'package:expense_tracker/features/transaction/presentation/page/edit_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/features/transaction/domain/entities/transaction_entity.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TransactionTile extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transaction.description),
      subtitle: Text(transaction.type),
      trailing: Row(  
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'ETB ${transaction.type == 'income' ? transaction.amount : -transaction.amount}',
                                style: TextStyle(
                                  color: transaction.type == 'income' 
                                      ? Colors.green 
                                      : const Color.fromARGB(255, 226, 39, 39),
                                      fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(  
                                icon: const Icon(Icons.delete, color: Colors.grey),
                                onPressed: () {
                                  context.read<TransactionBloc>().add(DeleteTransactionEvent(transaction.id));
                                },
                              ),
                              IconButton(onPressed: (){
                               
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditTransactionPage(transaction: transaction))
                                );
                              },
                               icon: const Icon(Icons.edit, color: Colors.lightBlue,))
                            ],
                          ),
    );
  }
}
