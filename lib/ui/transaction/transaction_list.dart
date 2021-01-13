import 'package:expenses/data/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTransaction;

  TransactionList(this._transactions, this.deleteTransaction) {
    initializeDateFormatting('en_US', null);
  }

  @override
  Widget build(context) => _transactions.isEmpty
      ? LayoutBuilder(
          builder: (ctx, constraints) => Column(
            children: [
              Text(
                "No transactions added yet!",
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(height: 10),
              Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/zzz.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        )
      : ListView.builder(
          itemCount: _transactions.length,
          itemBuilder: (buildContext, index) =>
              _TransactionCard(deleteTransaction, _transactions[index]),
        );
}

class _TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  _TransactionCard(this.deleteTransaction, this.transaction);

  @override
  Widget build(context) => Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              foregroundColor: Colors.black,
              radius: 30,
              child: getAmount(context)),
          title: getTitle(context),
          subtitle: getDate(),
          trailing: MediaQuery.of(context).size.width < 500
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteTransaction(transaction.id),
                  color: Theme.of(context).errorColor,
                )
              : FlatButton.icon(
                  onPressed: () => deleteTransaction(transaction.id),
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                  textColor: Theme.of(context).errorColor,
                ),
        ),
      );

  Widget getTitle(context) => Text(
        transaction.title,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.title,
      );

  Widget getAmount(context) => Container(
        padding: EdgeInsets.all(6),
        child: FittedBox(
          child: Text(
            "\$${transaction.amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );

  Widget getDate() => Text(
        DateFormat.yMMMd('en_US').format(transaction.date),
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      );
}
