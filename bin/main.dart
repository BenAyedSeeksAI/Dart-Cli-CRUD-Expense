import 'expense.dart';
import 'db.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print("Usage: dart run <command> [option]");
  }
  var func = switcher(arguments);
  func();
}

Function switcher(List<String> arguments) {
  final command = arguments[0];

  switch (command) {
    case "greet":
      return () => greet(arguments);
    case "create-db":
      return () => createDatabase(arguments);
    case "help-me-add":
      return () => helpMeAdd(arguments);
    case "help-me-multiply":
      return () => helpMeMultiply(arguments);
    case "add-expense":
      return () => addExpense(arguments);
    case "display-expenses":
      return () => displayExpenses(arguments);
    case "delete-expense-with-id":
      return () => deleteExpenseFromID(arguments);
    default:
      print("Unknown command: $command");
      return () => printHelp();
  }
}

void greet(List<String> arguments) {
  if (arguments.length < 2) {
    print('Usage: dart run greet <name>');
    return;
  }
  final name = arguments[1];
  print('Hello, $name!');
}

void createDatabase(List<String> arguments) {
  createAndOpenDatabase();
}

void helpMeAdd(List<String> arguments) {
  if (arguments.length < 3) {
    print("Usage: dart run help-me-add <option1> <option2>");
    return;
  }
  final a = int.parse(arguments[1]), b = int.parse(arguments[2]);
  var sm = a + b;
  print("$a + $b = $sm");
}

void helpMeMultiply(List<String> arguments) {
  if (arguments.length < 3) {
    print("Usage: dart run help-me-add <option1> <option2>");
    return;
  }
  final a = int.parse(arguments[1]), b = int.parse(arguments[2]);
  var prod = a * b;
  print("$a * $b = $prod");
}

void addExpense(List<String> arguments) {
  if (arguments.length < 6) {
    print("Usage: dart run help-me-add <option1> <option2>");
    return;
  }
  Expense exp = Expense(
      expenseName: arguments[1],
      category: arguments[2],
      amount: double.parse(arguments[3]),
      savedAmount: double.parse(arguments[4]),
      leisureOrWork: bool.parse(arguments[5]));
  exp.insertExpense();
  print("expense has been succesfully added");
}

void displayExpenses(List<String> arguments) {
  List<Expense> data = Expense.displayExpenses();
  print("List of expenses");
  for (Expense element in data) {
    print(
        "Expense: id:${element.id} name:${element.expenseName} category:${element.category} amount:${element.amount} Work:${(element.leisureOrWork ? "NO" : "YES")}");
  }
}

void deleteExpenseFromID(List<String> arguments) {
  if (arguments.length < 2) {
    print("Usage: dart run help-me-add <option1> <option2>");
    return;
  }
  Expense exp = Expense(
      expenseName: "",
      category: "",
      amount: 0.0,
      savedAmount: 0.0,
      leisureOrWork: false);
  exp.id = int.parse(arguments[1]);
  exp.deleteExpense();
}

void printHelp() {
  print('Available commands:');
  print('  greet             <name>         Greets the specified name.');
  print('  help-me-add       <opt1> <opt2>  add option1 and option2.');
  print('  help-me-multiply  <opt1> <opt2>  Multiply option1 and option2.');
}
