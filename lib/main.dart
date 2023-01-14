// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:expenses/components/chart.dart';
import 'package:flutter/material.dart';

import './components/transaction_form.dart';
import './components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(const Expenses());

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      // Aceita formato Brasileiro
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          titleMedium: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool darkMode = true;

  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Validade1',
      value: 33.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Validade2',
      value: 32.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Validade3',
      value: 34.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Validade4',
      value: 35.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Validade5',
      value: 36.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Validade6',
      value: 37.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Validade7',
      value: 38000.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Validade8',
      value: 3800.90,
      date: DateTime.now(),
    ),
  ];

  bool _showChart = false;

  // Filtra as transações recentes (por semana)
  // retorna verdadeiro ou falso
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteByIdTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // Modo paisagem
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    Widget _getIconButton(Icon icon, Function() fn) {
      return Platform.isIOS
          ? GestureDetector(onTap: fn, child: icon)
          : IconButton(onPressed: fn, icon: icon);
    }

    final actionsTopBar = <Widget>[
      // Botão alternativo para adicionar nova transação
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      if (isLandScape)
        // Botão para alternar a visualização: lista e gráfico
        _getIconButton(
          _showChart
              // Verifica a plataforma e verificar se o icone esta ativado
              ? Platform.isIOS
                  ? Icon(
                      CupertinoIcons.list_bullet_below_rectangle,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : Icon(Icons.poll_rounded,
                      color: Theme.of(context).colorScheme.secondary)
              : Platform.isIOS
                  ? const Icon(CupertinoIcons.list_bullet_below_rectangle)
                  : const Icon(Icons.poll_outlined),
          () {
            setState(() {
              if (_showChart) {
                _showChart = false;
              } else {
                _showChart = true;
              }
            });
          },
        ),
    ];

    final PreferredSizeWidget appBar = AppBar(
        title: Text(
          'Despesas Pessoais',
          style: TextStyle(
            fontSize: 20 * MediaQuery.textScaleFactorOf(context),
          ),
        ),
        actions: actionsTopBar);

    // Altura - barra do app - barra de status
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Implementação! - Fazer a transações mensais
            if (_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 0.8 : 0.26),
                child: Chart(recentTransaction: _recentTransactions),
              ),
            if (!_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 1 : 0.7),
                child: TransactionList(
                    transactions: _transactions,
                    onRemove: _deleteByIdTransaction),
              ),
          ],
        ),
      ),
    );

    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Despesas Pessoais'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: actionsTopBar,
          ),
        ),
        child: bodyPage,
      );
    } else {
      return Scaffold(
        appBar: appBar,
        body: bodyPage,
        floatingActionButton: Platform.isIOS
            ? Container()
            : FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => _openTransactionFormModal(context)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
  }
}
