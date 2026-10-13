import 'package:expense_tracker/features/transaction/domain/useCase/transaction_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc
    extends Bloc<TransactionEvent, TransactionState> {

      // action that a user can perform 
  final GetTransactionUseCase getTransactionUseCase;
  final GetAllTransactionUseCase getAllTransactionUseCase;
  final CreateTransactionUseCase createTransactionUseCase;
  final UpdateTransactionUseCase updateTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;
 

  TransactionBloc({
    required this.getAllTransactionUseCase,
    required this.getTransactionUseCase,
    required this.createTransactionUseCase,
    required this.updateTransactionUseCase,
    required this.deleteTransactionUseCase,
    
  }) : super(TransactionInitial()) {
    on<GetAllTransactionEvent>(_onGetAll);
    on<GetTransactionEvent>(_onGetTransaction);
    on<AddIncomeEvent>(_onAddIncome);
    on<AddExpenseEvent>(_onAddExpense);
    on<UpdateTransactionEvent>(_onUpdate);
    on<DeleteTransactionEvent>(_onDelete);
   
  }

  
  
  Future<void> _onGetAll(
    GetAllTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await getAllTransactionUseCase();

    result.fold(
      (failure) {
        emit(TransactionFailure(failure.massage));
      },
      (transactions) {
        emit(TransactionLoaded(transactions));
      },
    );
  }

  Future<void> _onGetTransaction(
    GetTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await getTransactionUseCase(event.id);

    result.fold(
      (failure) {
        emit(TransactionFailure(failure.massage));
      },
      (transaction) {
        emit(TransactionLoaded([transaction]));
      },
    );
  }

Future<void> _onAddIncome(
  AddIncomeEvent event,
  Emitter<TransactionState> emit,
) async {
  debugPrint('ADD INCOME EVENT RECEIVED');

  emit(TransactionLoading());

  debugPrint('CALLING CREATE USE CASE');

  final result = await createTransactionUseCase(event.transaction);

  debugPrint('CREATE USE CASE FINISHED');

  result.fold(
    (failure) {
      debugPrint('CREATE FAILED: ${failure.massage}');

      emit(
        TransactionFailure(
          'Creating income failed: ${failure.massage}',
        ),
      );
    },
    (_) {
      debugPrint('CREATE SUCCESS');

      emit(
        TransactionActionSuccess(
          'Income added successfully!',
        ),
      );
    },
  );
}

  Future<void> _onAddExpense(
  AddExpenseEvent event,
  Emitter<TransactionState> emit,
) async {
  debugPrint('ADD EXPENSE EVENT RECEIVED');

  emit(TransactionLoading());

  debugPrint('CALLING CREATE USE CASE');

  final result = await createTransactionUseCase(event.transaction);

  debugPrint('CREATE USE CASE FINISHED');

  result.fold(
    (failure) {
      debugPrint('CREATE FAILED: ${failure.massage}');

      emit(
        TransactionFailure(
          'Creating expense failed: ${failure.massage}',
        ),
      );
    },
    (_) {
      debugPrint('CREATE SUCCESS');

      emit(
        TransactionActionSuccess(
          'Expense added successfully!',
        ),
      );
    },
  );
}

  Future<void> _onUpdate(
    UpdateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result =
        await updateTransactionUseCase(event.transaction);

    result.fold(
      (failure) {
        emit(
          TransactionFailure(
            'Updating transaction failed: ${failure.massage}',
          ),
        );
      },
      (_) async {
        emit(
          TransactionActionSuccess(
            'Transaction updated successfully!',
          ),
        );

        await _reloadTransactions(emit);
      },
    );
  }

  Future<void> _onDelete(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result =
        await deleteTransactionUseCase(event.id);

    result.fold(
      (failure) {
        emit(
          TransactionFailure(
            'Deleting transaction failed: ${failure.massage}',
          ),
        );
      },
      (_) async {
        emit(
          TransactionActionSuccess(
            'Transaction deleted successfully!',
          ),
        );

        await _reloadTransactions(emit);
      },
    );
  }

  Future<void> _reloadTransactions(
    Emitter<TransactionState> emit,
  ) async {
    final result = await getAllTransactionUseCase();

    result.fold(
      (failure) {
        emit(
          TransactionFailure(
            'Transaction saved, but loading the list failed: ${failure.massage}',
          ),
        );
      },
      (transactions) {
        emit(TransactionLoaded(transactions));
      },
    );
  }
}


class NetWrothBloc extends Bloc< NetWorthEvent, NetWorthState> {
  final GetNetWorthUseCase getNetWorthUseCase;

  NetWrothBloc({
    required this.getNetWorthUseCase
  }): super(NetWorthInitial()){
    on<GetNetWorthEvent>(_onNetWorth);
  }


  Future<void> _onNetWorth( 
    GetNetWorthEvent event,
    Emitter<NetWorthState> emit) async{
      emit(NetWorthLoading());
      final result = await getNetWorthUseCase();

      result.fold( 
        (failure){

          emit(NetWorthFailure(failure.massage));
        },
        (totalWorth){
          emit(
            NetWorthLoaded(totalWorth),
           
          );
         
        }
      );
    }
}