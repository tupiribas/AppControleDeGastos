import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart({super.key, required this.recentTransaction});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      // Formatação do dia da semana
      final weekDay = DateTime.now().subtract(Duration(days: index));

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

      return {'day': DateFormat('E ', 'pt_BR').format(weekDay), 'value': totalSum};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactions.map((tr) {
          return Flexible(
            fit: FlexFit.tight,
            child: Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: ChartBar(
                weekDay: tr['day'].toString(),
                value: tr['value'] as double,
                percentage: _weekTotalValue == 0
                    ? 0
                    : (tr['value'] as double) / _weekTotalValue,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
