import 'package:expense_tracker_app/model/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  Expense expense;

  ExpensesItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Text('RS ${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              expense.category.categoryIcon,
              const SizedBox(
                width: 5,
              ),
              Text(expense.formattedDate),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
