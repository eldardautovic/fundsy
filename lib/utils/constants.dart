import 'package:flutter/material.dart';

class Category {
  final String name;
  final Icon icon;

  const Category(this.name, this.icon);
}

class Categories {
  static const Category diningOut =
      Category('Dining Out', Icon(Icons.fastfood));
  static const Category entertainment =
      Category('Entertainment', Icon(Icons.theater_comedy));
  static const Category shopping =
      Category('Shopping', Icon(Icons.shopping_bag));
  static const Category subscriptions =
      Category('Subscriptions & Memberships', Icon(Icons.card_membership));
  static const Category travelVacation =
      Category('Travel & Vacation', Icon(Icons.airplanemode_active));
  static const Category giftsDonations =
      Category('Gifts & Donations', Icon(Icons.card_giftcard));
  static const Category personalCare =
      Category('Personal Care', Icon(Icons.brush));

  static const List<Category> all = [
    diningOut,
    entertainment,
    shopping,
    subscriptions,
    travelVacation,
    giftsDonations,
    personalCare
  ];
}

class Utility {
  final String name;
  final Icon icon;

  const Utility(this.name, this.icon);
}

class Utilities {
  static const Utility housing = Utility(
      'Housing',
      Icon(
        Icons.house,
        size: 18,
      ));
  static const Utility utilities = Utility(
      'Utilities',
      Icon(
        Icons.energy_savings_leaf,
        size: 18,
      ));
  static const Utility groceries = Utility(
      'Groceries',
      Icon(
        Icons.local_grocery_store,
        size: 18,
      ));
  static const Utility transportation = Utility(
      'Transportation',
      Icon(
        Icons.directions_car,
        size: 18,
      ));
  static const Utility insurance = Utility(
      'Insurance',
      Icon(
        Icons.save,
        size: 18,
      ));
  static const Utility debtPayments = Utility(
      'Debt Payments',
      Icon(
        Icons.credit_card,
        size: 18,
      ));
  static const Utility medicalHealthcare = Utility(
      'Medical & Healthcare',
      Icon(
        Icons.local_hospital,
        size: 18,
      ));

  static const List<Utility> all = [
    housing,
    utilities,
    groceries,
    transportation,
    insurance,
    debtPayments,
    medicalHealthcare,
  ];
}

enum UtilityEnum {
  housing('Housing', Icons.house),
  utilities('Utilities', Icons.energy_savings_leaf),
  groceries('Groceries', Icons.local_grocery_store),
  transportation('Transportation', Icons.directions_car),
  insurance('Insurance', Icons.save),
  debtPayments('Debt Payments', Icons.credit_card),
  medicalHealthcare('Medical & Healthcare', Icons.local_hospital);

  const UtilityEnum(this.name, this.iconData);

  final String name;
  final IconData iconData;

  Icon get icon => Icon(iconData, size: 18);

  static UtilityEnum fromName(String name) {
    return UtilityEnum.values.firstWhere(
      (utility) => utility.name == name,
      orElse: () => housing, // Vrati housing kao default
    );
  }
}
