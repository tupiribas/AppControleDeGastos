import 'package:flutter/material.dart';

import 'package:expenses/models/transaction.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'dart:math';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onRemove,
  }) : super(key: key);

  String _formatTotalValue(double value) {
    return 'R\$${value >= pow(10, 3) && value < pow(10, 6) ? '${value.toString()[0]}K' : value >= pow(10, 6) && value < pow(10, 12) ? '${value.toString()[0]}M' : value >= pow(10, 12) ? '${value.toString()[0]}T' : value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 40),
                    height: 200,
                    child: Image.asset(
                      'assets\\images\\waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          _formatTotalValue(tr.value),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => onRemove(tr.id),
                  ),
                ),
              );
            });
  }
}
