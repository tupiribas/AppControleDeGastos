import 'dart:math';

import 'package:flutter/material.dart';

import '../components/transaction_form.dart';
import '../components/transaction_list.dart';
import '../models/transaction.dart';

class TransactionUserState extends StatefulWidget {
  const TransactionUserState({super.key});

  @override
  State<TransactionUserState> createState() => _TransactionUserStateState();
}

class _TransactionUserStateState extends State<TransactionUserState> {
  final _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tenis de corrida',
        value: 310.70,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Conta de luz', value: 151.15, date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(transactions: _transactions),
        TransactionForm(onSubmit: _addTransaction),
      ],
    );
  }
}
