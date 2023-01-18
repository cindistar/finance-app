import 'package:flutter/material.dart';
import 'package:test/locator.dart';
import 'package:test/presentation/expenses/controller/expenses_controller.dart';
import 'package:test/presentation/expenses/controller/expenses_state.dart';
import 'package:test/presentation/expenses/widgets/bottom_sheet_expenses_widget.dart';
import 'package:test/resources/colors.dart';
import 'package:test/resources/shared_widgets/transaction_widget.dart';
import 'package:test/resources/strings.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final expensesController = ExpensesController(
      authRepository: getIt(), transactionRepository: getIt());

  @override
  void initState() {
    super.initState();
    expensesController.getExpensesTransactionsList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<ExpensesState>(
          valueListenable: expensesController,
          builder: (_, state, __) {
            if (state is ExpensesLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.blueVibrant,
              ));
            }
            if (state is ExpensesSuccessState) {
              return TransactionWidget(
                appBarTitle: Strings.expenses,
                appBarColor: AppColors.redWine,
                date: '13 de outubro',
                transactionsList: state.expensesListModel,
              );
            }
            if (state is ExpensesErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          },
        ),
        bottomSheet: const BottomSheetExpensesWidget(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: FloatingActionButton(
            backgroundColor: AppColors.redWine,
            onPressed: () => Navigator.of(context).pushNamed('/add_expense'),
            tooltip: 'Adicionar despesa',
            child: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColors.whiteSnow,
            ),
          ),
        ),
      ),
    );
  }
}
