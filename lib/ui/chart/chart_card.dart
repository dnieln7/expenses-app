import 'package:expenses/data/model/transaction.dart';
import 'package:expenses/ui/chart/chart_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartCard extends StatelessWidget {
  final List<Transaction> transactions;

  ChartCard(this.transactions);

  @override
  Widget build(context) => Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues
                .map((transactionDay) => Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                        transactionDay["day"],
                        transactionDay["amount"],
                        (transactionDay["amount"] as double) / maxAmount,
                      ),
                    ))
                .toList(),
          ),
        ),
      );

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) => createDay(index));
  }

  Map<String, Object> createDay(index) {
    final weekDay = DateTime.now().subtract(Duration(days: index));

    var totalAmount = 0.0;

    transactions.forEach((transaction) => {
          if (transaction.date.day == weekDay.day &&
              transaction.date.month == weekDay.month &&
              transaction.date.year == weekDay.year)
            {totalAmount += transaction.amount}
        });

    return {
      "day": DateFormat.E().format(weekDay).substring(0, 3),
      "amount": totalAmount,
    };
  }

  double get maxAmount {
    return groupedTransactionValues.fold(
        0.0, (sum, transactionDay) => sum + transactionDay["amount"]);
  }
}
