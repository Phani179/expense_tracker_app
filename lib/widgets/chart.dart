import 'dart:math';

import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({required this.expenses, super.key});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets => Category.values
      .map((category) => ExpenseBucket.fromCategory(category, expenses))
      .toList();

  double get maxExpense {
    double maxExpense = 0;
    for (ExpenseBucket bucket in buckets) {
      maxExpense = max(maxExpense, bucket.totalExpense);
    }
    return maxExpense;
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.secondaryContainer
            ]),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (ExpenseBucket bucket in buckets)
                  ChartBar(
                    fill:
                        maxExpense == 0 ? 0 : bucket.totalExpense / maxExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              for (Category category in Category.values)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: category.categoryIcon,
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
