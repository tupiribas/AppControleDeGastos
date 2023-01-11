import 'package:flutter/material.dart';
import 'dart:math';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final double value;
  final double percentage;

  const ChartBar({
    super.key,
    required this.weekDay,
    required this.value,
    required this.percentage,
  });

  String get _formatTotalValue {
    return value >= pow(10, 3) && value < pow(10, 6)
        ? '${value.toString()[0]}K'
        : value >= pow(10, 6) && value < pow(10, 12)
            ? '${value.toString()[0]}M'
            : value >= pow(10, 12)
                ? '${value.toString()[0]}T'
                : value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            // Valor da despesa
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  _formatTotalValue,
                  style: const TextStyle(
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ),
            // -- Separador --
            SizedBox(height: constraints.maxHeight * 0.05),
            // Gráfico
            SizedBox(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // -- Separador --
            SizedBox(height: constraints.maxHeight * 0.05),
            // Dia da semana
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  weekDay,
                  style: const TextStyle(
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
