import 'package:expenses/data/model/transaction.dart';
import 'package:expenses/data/service/transaction_data_service.dart';
import 'package:expenses/ui/chart/chart_card.dart';
import 'package:expenses/ui/home/chart_switch.dart';
import 'package:expenses/ui/home/expenses_widgets.dart';
import 'package:expenses/ui/transaction/transaction_form.dart';
import 'package:expenses/ui/transaction/transaction_list.dart';
import 'package:flutter/material.dart';

class ExpensesHome extends StatefulWidget {
  @override
  _ExpensesHomeState createState() => _ExpensesHomeState();
}

class _ExpensesHomeState extends State<ExpensesHome> {
  TransactionDataService dataService;
  MediaQueryData mediaQuery;
  bool chartActivated;
  bool isLandScape;

  _ExpensesHomeState() {
    dataService = TransactionDataService();
    chartActivated = false;
  }

  Widget build(context) => Scaffold(
        appBar: ExpensesWidgets.appBar(() => showTransactionForm(context)),
        body: expensesBody(context),
        floatingActionButton:
            ExpensesWidgets.fabAdd(() => showTransactionForm(context)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  Widget expensesBody(context) {
    mediaQuery = MediaQuery.of(context);
    isLandScape = mediaQuery.orientation == Orientation.landscape;

    var chartSwitchHeight;
    var chartCardHeight;
    var transactionListHeight;

    if (isLandScape) {
      chartSwitchHeight = (mediaQuery.size.height -
              ExpensesWidgets.appBarSize.height -
              mediaQuery.padding.top) *
          0.1;

      chartCardHeight = (mediaQuery.size.height -
              ExpensesWidgets.appBarSize.height -
              mediaQuery.padding.top) *
          0.6;

      transactionListHeight = (mediaQuery.size.height -
              ExpensesWidgets.appBarSize.height -
              mediaQuery.padding.top) *
          0.9;
    } else {
      chartCardHeight = (mediaQuery.size.height -
              ExpensesWidgets.appBarSize.height -
              MediaQuery.of(context).padding.top) *
          0.3;

      transactionListHeight = (mediaQuery.size.height -
              ExpensesWidgets.appBarSize.height -
              MediaQuery.of(context).padding.top) *
          0.7;
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandScape)
            ChartSwitch(
              "Show Chart",
              chartActivated,
              (val) => setState(() => chartActivated = val),
              chartSwitchHeight,
            ),
          if (!isLandScape)
            Container(
              height: chartCardHeight,
              child: ChartCard(dataService.recentTransactions),
            ),
          if (!isLandScape)
            Container(
                height: transactionListHeight,
                child: TransactionList(
                    dataService.transactions, deleteTransaction)),
          if (isLandScape)
            chartActivated
                ? Container(
                    height: chartCardHeight,
                    child: ChartCard(dataService.recentTransactions),
                  )
                : Container(
                    height: transactionListHeight,
                    child: TransactionList(
                        dataService.transactions, deleteTransaction),
                  ),
        ],
      ),
    );
  }

  void addTransaction(String title, double amount, date) => setState(
        () => dataService.addTransaction(
            Transaction(DateTime.now().toString(), title, amount, date)),
      );

  void deleteTransaction(String id) => setState(
        () => dataService.deleteTransaction(id),
      );

  void showTransactionForm(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (_) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: TransactionForm(addTransaction),
        ),
      );
}
