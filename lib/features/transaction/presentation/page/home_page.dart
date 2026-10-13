import 'package:expense_tracker/features/transaction/presentation/page/add_transaction_page.dart';
import 'package:expense_tracker/features/transaction/presentation/page/get_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';
import '../widget/transaction_tile.dart';
// Ensure your NetWrothBloc, NetWorthState, and GetNetWorthEvent are imported here

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Transactions'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TransactionBloc, TransactionState>(  
            // listeners help us for snackbar messages 
            listener: (context, state) {
              if (state is TransactionActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar( 
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green[300],
                  ),
                );

                // while updating the home page by new transaction , also update the netWorth value 
                context.read<TransactionBloc>().add(GetAllTransactionEvent());
                context.read<NetWrothBloc>().add(GetNetWorthEvent());

              } else if (state is TransactionFailure) {
                ScaffoldMessenger.of(context).showSnackBar( 
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red[300],
                  ),
                );
              }
            },
          ),

          // BlocListener<NetWrothBloc, NetWorthState>(  
          //   listener: (context , state){
          //     if( state is NetWorthFailure){
          //       ScaffoldMessenger.of(context).showSnackBar( 
          //         SnackBar(content: Text(state.errorMessage))
          //       );

          //     }
          //     else if ( state is NetWorthSuccessAction){
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text( state.successMessage
          //         ),
          //         backgroundColor: Colors.green,
                  
          //         )
          //       );
          //       context.read<NetWrothBloc>().add(GetNetWorthEvent());
          //     }
          //   },
          // )
        ],
        child: BlocBuilder<TransactionBloc, TransactionState>(  
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(  
                child: CircularProgressIndicator(),
              );
            } 
            
            if (state is TransactionFailure) {
              return Center(  
                child: Text(  
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state is TransactionLoaded) {
              final list = state.transactions;
              if (list.isEmpty) {
                return const Center(  
                  child: Text("No transaction found."),
                );
              }

              return Column(
                children: [
                  BlocBuilder<NetWrothBloc, NetWorthState>(
                    builder: (context, netWorthState) {
                      double total = 0.0;
                      bool isLoading = false;

                      if (netWorthState is NetWorthLoading) { 
                        isLoading = true;
                      } 
                       if (netWorthState is NetWorthLoaded) {
                        total = netWorthState.total;
                      }
                      
                      return Card(
                        margin: const EdgeInsets.all(25),
        
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Row(  
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [ 
                              const Text(
                                'Net Worth ',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              isLoading 
                                  ? const SizedBox( 
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 3),
                                    )
                                  : Text(
                                      'ETB ${total.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: total >= 0 ? Colors.green : Colors.red,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    
                    child: ListView.builder(  
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final tx = list[index];
                        return InkWell(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            GetTransactionPage(transaction: tx)));
                             },
                        child:TransactionTile(transaction: tx)
                        // ListTile(
                        //   title: Text(tx.description,
                        //   style:  TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold
                        //   ),),
                        //   subtitle: Text(tx.date.toString().split(' ')[0]
                        //   , ),
                        //   trailing: Row(  
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Text(
                        //         'ETB ${tx.type == 'income' ? tx.amount : -tx.amount}',
                        //         style: TextStyle(
                        //           color: tx.type == 'income' 
                        //               ? Colors.green 
                        //               : const Color.fromARGB(255, 226, 39, 39),
                        //               fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       IconButton(  
                        //         icon: const Icon(Icons.delete, color: Colors.grey),
                        //         onPressed: () {
                        //           context.read<TransactionBloc>().add(DeleteTransactionEvent(tx.id));
                        //         },
                        //       ),
                        //       IconButton(onPressed: (){},
                        //        icon: const Icon(Icons.edit, color: Colors.lightBlue,))
                        //     ],
                        //   ),
                        // ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push( 
            context, 
            MaterialPageRoute(builder: (context) => const AddTransactionPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
