import 'dart:io';

import 'package:expense_tracker_app/model/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.addExpense, super.key});

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Inavlid input"),
          content: const Text(
              "Please make sure a valid title, amount, date and category was entered."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text("Inavlid input"),
          content: const Text(
              "Please make sure a valid title, amount, date and category was entered."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  // Invalid input
  // Please make sure a valid title, amount, date and category was entered.
  void _isValidDataEntered() {
    final enteredAmount = double.tryParse(_amountController.text.trim());
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      _showDialog();
    } else {
      widget.addExpense(Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: selectedDate!,
          category: _selectedCategory));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, keyboardInset + 20),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          // maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "RS. ",
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                    ),
                  ),
                if (width >= 600)
                  Column(
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(selectedDate == null
                                    ? "No date selected"
                                    : dateFormatter.format(selectedDate!)),
                                IconButton(
                                  onPressed: _datePicker,
                                  icon: const Icon(Icons.calendar_month),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "RS. ",
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(selectedDate == null
                                ? "No date selected"
                                : dateFormatter.format(selectedDate!)),
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (width >= 600)
                  Column(
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                            onPressed: _isValidDataEntered,
                            child: const Text("Add"),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: _isValidDataEntered,
                        child: const Text("Add"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
