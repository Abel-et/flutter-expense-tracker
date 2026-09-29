import 'package:expense_tracker/features/transaction/presentation/page/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';


class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Transactions'),
      ),
      body: BlocListener<TransactionBloc, TransactionState>(  
        listener: (context, state){
          if(state is TransactionActionSuccess){
            ScaffoldMessenger.of(context).showSnackBar( 
              SnackBar(content: Text(state.message),backgroundColor: Colors.green[300],)
              
            );
            context.read<TransactionBloc>().add(GetAllTransactionEvent());
           
          } else if (state is TransactionFailure){
            ScaffoldMessenger.of(context).showSnackBar( 
              SnackBar(content: Text(state.errorMessage),backgroundColor: Colors.red[300],)
            );
          }
        },

        child: BlocBuilder<TransactionBloc, TransactionState>(  
          builder : (context, state){
            if(state is TransactionLoading){
              return const Center(  
                child: CircularProgressIndicator()
              );
            } else if( state is TransactionLoaded){
              final list = state.transactions;
              if(list.isEmpty){
                return const Center(  
                  child:Text("No transaction found ."),
                );
              }

              return ListView.builder(  
                itemCount: list.length,
                itemBuilder: (context, index){
                  final tx = list[index];
                  return ListTile(
                    title: Text(tx.description),
                    subtitle: Text(tx.date.toString().split(' ')[0]),
                    trailing: Row(  
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('ETB${tx.type == 'income' ? tx.amount : -tx.amount}',
                        style: TextStyle(color: tx.type == 'income' ? Colors.green : const Color.fromARGB(255, 226, 39, 39)),
                        ),
                        IconButton(  
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed:(){
                            context.read<TransactionBloc>().add(DeleteTransactionEvent(tx.id));
                          }
                        )
                      ],
                    ),
                  );
                },
              );
            }
            if(state is TransactionFailure){
              return Center(  
                child: Text(  
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
              );
            }
             return const Center(
        child: CircularProgressIndicator(),
      );
          }
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push( 
          context, 
          MaterialPageRoute(builder: (context) => const AddTransactionPage())
        );
        
      },
      child: const Icon(Icons.add),
      ),
    );
  }
}