import 'db.dart';

final dBPath = "expense.db";

class Expense {
  int? id;
  final String expenseName;
  final String category;
  final double amount;
  final double savedAmount;
  final bool leisureOrWork;

  Expense(
      {this.id,
      required this.expenseName,
      required this.category,
      required this.amount,
      required this.savedAmount,
      required this.leisureOrWork});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expenseName': expenseName,
      'category': category,
      'amount': amount,
      'savedAmount': savedAmount,
      'leisureOrWork': leisureOrWork,
    };
  }

  void insertExpense() {
    dbInsertExpense(this);
  }

  void deleteExpense() {
    dbDeleteExpenseByID(this);
  }

  static List<Expense> displayExpenses() {
    return dbDisplayExpenses();
  }

  void saveToDB() {
    var expense = expenseName;
    print("$expense is going to be saved in DB");
  }

  void deleteFromDB() {
    var expense = expenseName;
    print("$expense is going to be saved in DB");
  }

  @override
  String toString() {
    return "Expense: $expenseName";
  }
}
