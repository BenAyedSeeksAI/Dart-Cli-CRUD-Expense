import 'package:sqlite3/sqlite3.dart';
import 'expense.dart';

final dbStorage = "database.db";

void createAndOpenDatabase() async {
  final database = sqlite3.open('database.db');

  // Create a table
  database.execute('''
    CREATE TABLE IF NOT EXISTS expenses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      expenseName TEXT,
      category TEXT,
      amount REAL,
      savedAmount REAL,
      leisureOrWork TEXT
    )
  ''');

  print('Database initialized.');
  database.dispose();
}

void dbInsertExpense(Expense exp) {
  final db = sqlite3.open(dbStorage);
  final stmt = db.prepare('''
    INSERT INTO expenses (expenseName, category, amount, savedAmount, leisureOrWork)
    VALUES (?, ?, ?, ?, ?)
  ''');
  stmt.execute([
    exp.expenseName,
    exp.category,
    exp.amount,
    exp.savedAmount,
    exp.leisureOrWork,
  ]);
  stmt.dispose(); // Always dispose the statement when done
  print('Expense inserted: ${exp.expenseName}');
  db.dispose();
}

List<Expense> dbDisplayExpenses() {
  List<Expense> ans = [];
  final db = sqlite3.open(dbStorage);
  final result = db.select('SELECT * FROM expenses');
  for (final row in result) {
    Expense exp = Expense(
        expenseName: row['expenseName'],
        category: row['category'],
        amount: row['amount'].toDouble(),
        savedAmount: row['savedAmount'].toDouble(),
        leisureOrWork: (int.parse(row['leisureOrWork'])) == 1);
    exp.id = row['id'];
    ans.add(exp);
  }
  db.dispose();
  return ans;
}

void dbDeleteExpenseByID(Expense exp) {
  final db = sqlite3.open(dbStorage);
  final stmt = db.prepare('''
    DELETE FROM expenses WHERE id = ?
  ''');
  stmt.execute([exp.id]);
  stmt.dispose();
  print("record has been deleted ...");
  db.dispose();
}
