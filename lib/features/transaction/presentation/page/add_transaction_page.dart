import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  String _type = 'expense';

  @override
  void dispose() {
    _descController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                hintText: 'Write Reason for this Transaction',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _amountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
                hintText: 'How much',
              ),
            ),
            DropdownButton<String>(
              value: _type,
              isExpanded: true,
              items: [
                DropdownMenuItem(value: 'income', child: Text('Income')),
                DropdownMenuItem(value: 'expense', child: Text("Expense")),
              ],
              onChanged: (value) => setState(() => _type = value!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_descController.text.trim().isEmpty ||
                    _amountController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill out all fields')),
                  );
                  return;
                }
                final amount = double.tryParse(_amountController.text.trim());

                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a valid amount greater than 0'),
                    ),
                  );
                  return;
                }
                final entity = TransactionEntity(
                  id: DateTime.now().millisecondsSinceEpoch % 1000000000,
                  amount: amount,
                  type: _type,
                  date: DateTime.now(),
                  description: _descController.text.trim(),
                );
                if (_type == 'income') {
                  context.read<TransactionBloc>().add(AddIncomeEvent(entity));
                } else {
                  context.read<TransactionBloc>().add(AddExpenseEvent(entity));
                }
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
