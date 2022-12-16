import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      // Dia da semana: subtrai o dia atual pela quantidade de dias
      final weekDay = DateTime.now().subtract(Duration(days: index));

      // Formata o dia da semana
      final weekDayFormat = DateFormat.E().format(weekDay)[0];

      // Soma dos valores
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

      return {'day': weekDayFormat, 'value': 9.99};
    });
  }

  const Chart({super.key, required this.recentTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
