import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final dateFormatter = DateFormat.yMMMMd();

const uuid = Uuid();

enum Category {
  food(Icon(Icons.lunch_dining)),
  travel(Icon(Icons.flight_takeoff)),
  leisure(Icon(Icons.movie)),
  work(Icon(Icons.work));

  final Icon categoryIcon;

  const Category(this.categoryIcon);
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate => dateFormatter.format(date);
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  // Utility Constructor
  ExpenseBucket.fromCategory(
    this.category,
    List<Expense> allExpenses,
  ) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double total = 0;
    for (Expense e in expenses) {
      total += e.amount;
    }
    return total;
  }
}
