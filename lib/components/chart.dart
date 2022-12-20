import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:expenses/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      // Formatação:
      // Dia da semana: subtrai o dia atual pelo dia atual
      final weekDay = DateTime.now().subtract(Duration(days: index));
      // Formata o dia da semana
      final weekDayFormat =
          DateFormat.E('pt_BR').format(weekDay)[0].toUpperCase();

      // Reconhece a ultima transação feita e adiciona o valor da transação ao
      // dia expecífico.
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      // Parei aqui
      print(totalSum);
      print(weekDayFormat);

      return {'day': weekDayFormat, 'value': totalSum};
    });
  }

  const Chart({super.key, required this.recentTransaction});

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
