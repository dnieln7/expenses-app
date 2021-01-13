import 'package:flutter/material.dart';

class ExpensesWidgets {
  static Size appBarSize;

  static Widget appBar(addAction) {
    AppBar appBar = AppBar(
      title: Text("Expenses Calculator"),
      actions: [IconButton(icon: Icon(Icons.add), onPressed: addAction)],
    );

    appBarSize = appBar.preferredSize;

    return appBar;
  }

  static Widget fabAdd(addAction) => FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addAction,
      );
}
