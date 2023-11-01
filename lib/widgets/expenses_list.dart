import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  List<Expense> expenses;

  ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            margin: EdgeInsets.symmetric(
                horizontal:
                    Theme.of(context).cardTheme.margin?.horizontal ?? 16),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
            ),
          ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) => removeExpense(expenses[index]),
          child: ExpensesItem(expense: expenses[index]),
        );
      },
    );
  }
}
