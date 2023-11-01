import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/widgets/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense> expenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      expenses.add(
        expense,
      );
    });
  }

  void _removeExpense(Expense expense) {
    int expenseIndex = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted."),
        action: SnackBarAction(
          textColor: Colors.blueAccent,
          label: "Undo",
          onPressed: () {
            setState(() {
              expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          addExpense: _addExpense,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = expenses.isEmpty
        ? const Center(
            child: Text(
              "No Expenses Found. Start adding some!",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : width < 600
            ? Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Chart(expenses: expenses),
                  Expanded(
                    child: ExpensesList(
                      expenses: expenses,
                      removeExpense: _removeExpense,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Chart(expenses: expenses)),
                  Expanded(
                    child: ExpensesList(
                      expenses: expenses,
                      removeExpense: _removeExpense,
                    ),
                  ),
                ],
              );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expenses App"),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: mainContent,
    );
  }
}
