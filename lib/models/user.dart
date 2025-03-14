import 'package:flutter/material.dart';

final String tableUser = 'User';
final String columnId = 'id';
final String columnBalance = 'balance';

class User extends ChangeNotifier {
  int id = 0;
  double balance = 0.0;
  double perDaySpending = 0.0;

  static final User _instance = User._internal();

  factory User() {
    return _instance;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnBalance: balance,
    };
    // ignore: unnecessary_null_comparison
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  User._internal();

  void subtract(double amount) {
    balance -= amount;

    calculatePerDayBalance();
    notifyListeners();
  }

  void calculatePerDayBalance() {
    var daysLeft =
        DateUtils.getDaysInMonth(DateTime.now().year, DateTime.now().month) -
            DateTime.now().day;

    perDaySpending = balance / daysLeft;

    notifyListeners();
  }

  Future<void> setBalance(double amount) async {
    balance = amount;
    calculatePerDayBalance();
    notifyListeners();
  }
}
