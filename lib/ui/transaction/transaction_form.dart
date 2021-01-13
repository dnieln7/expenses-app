import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function addTransaction;

  TransactionForm(this.addTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final title = TextEditingController();
  final amount = TextEditingController();

  DateTime selectedDate;

  @override
  Widget build(context) => SingleChildScrollView(
        child: Card(
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                createTextField("title", title, TextInputType.text),
                createTextField("amount", amount,
                    TextInputType.numberWithOptions(decimal: true)),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(selectedDate == null
                            ? "No Date Chosen!"
                            : DateFormat.yMd().format(selectedDate)),
                      ),
                      FlatButton(
                          onPressed: showDate,
                          textColor: Theme.of(context).primaryColor,
                          child: Text("Choose Date"))
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: submit,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text("Add transaction"),
                ),
              ],
            ),
          ),
        ),
      );

  Widget createTextField(label, controller, keyboard) => TextField(
        decoration: InputDecoration(labelText: label),
        controller: controller,
        keyboardType: keyboard,
        //onSubmitted: (_) => submit(),
      );

  void submit() {
    if (title.text.isNotEmpty &&
        double.parse(amount.text) > 0 &&
        selectedDate != null) {
      widget.addTransaction(
          title.text, double.parse(amount.text), selectedDate);
      Navigator.of(context).pop();
    }
  }

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) => {
          if (pickedDate != null) {setState(() => selectedDate = pickedDate)}
        });
  }
}
