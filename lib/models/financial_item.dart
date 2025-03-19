abstract class FinancialItem {
  String category = '';
  String createdAt = DateTime.now().toIso8601String();
  double balance = 0.0;

  FinancialItem();
}
