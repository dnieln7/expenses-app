import 'package:expenses/data/model/transaction.dart';

class TransactionDataService {
  List<Transaction> _transactions;

  TransactionDataService() {
    _fetchData();
  }

  List<Transaction> get transactions => _transactions;

  List<Transaction> get recentTransactions => _transactions
      .where((transaction) =>
          transaction.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
      .toList();

  Transaction transactionById(id) =>
      _transactions.where((transaction) => transaction.id == id).first;

  void addTransaction(Transaction transaction) =>
      _transactions.add(transaction);

  void deleteTransaction(id) =>
      _transactions.removeWhere((transaction) => transaction.id == id);

  void _fetchData() {
    _transactions = [
      Transaction(
        "T1",
        "New Shoes",
        69.99,
        DateTime.now(),
      ),
      Transaction(
        "T2",
        "Weekly groceries",
        16.53,
        DateTime.now().subtract(Duration(days: 2)),
      ),
      Transaction(
        "T3",
        "New phone",
        150.00,
        DateTime.now().subtract(Duration(days: 5)),
      ),
      Transaction(
        "T4",
        "Gasoline",
        60.00,
        DateTime.now().subtract(Duration(days: 1)),
      ),
      Transaction(
        "T5",
        "Meals",
        30.50,
        DateTime.now().subtract(Duration(days: 1)),
      ),
      Transaction(
        "T6",
        "Clothes",
        89.90,
        DateTime.now().subtract(Duration(days: 2)),
      ),
      Transaction(
        "T7",
        "Office stuff",
        12.88,
        DateTime.now().subtract(Duration(days: 5)),
      ),
      Transaction(
        "T8",
        "Pre-made food",
        20.25,
        DateTime.now().subtract(Duration(days: 6)),
      ),
    ];
  }
}
