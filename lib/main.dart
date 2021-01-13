import 'package:expenses/ui/home/expenses_home.dart';
import 'package:flutter/material.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  Widget build(context) => MaterialApp(
        title: "Expenses Calculator",
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.redAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                subhead: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.black,
                ),
                button: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
            color: Colors.purple.shade800,
            textTheme: ThemeData.dark().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'QuickSand', fontSize: 20),
                ),
          ),
        ),
        home: ExpensesHome(),
      );
}
