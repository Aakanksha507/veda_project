import 'package:flutter/material.dart';

enum ExpensesCategory {
  waterBill,
  electricityBill,
  internetBill,
  salaries,
  transportation,
}

extension ExpensesCategoryExtension on ExpensesCategory {
  String get label {
    switch (this) {
      case ExpensesCategory.waterBill:
        return "Water Bill";
      case ExpensesCategory.electricityBill:
        return "Electricity Bill";
      case ExpensesCategory.internetBill:
        return "Internet Bill";
      case ExpensesCategory.salaries:
        return "Salaries";
      case ExpensesCategory.transportation:
        return "Transportation";
    }
  }

  String get svgAsset {
    switch (this) {
      case ExpensesCategory.waterBill:
        return 'assets/icon/water.svg';
      case ExpensesCategory.electricityBill:
        return 'assets/icon/electricity.svg';
      case ExpensesCategory.internetBill:
        return 'assets/icon/bill.svg';
      case ExpensesCategory.salaries:
        return 'assets/icon/income.svg';
      case ExpensesCategory.transportation:
        return 'assets/icon/bill.svg';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case ExpensesCategory.waterBill:
        return Color(0xFF3629B7);
      case ExpensesCategory.electricityBill:
        return Color(0xFF0890FE);
      case ExpensesCategory.internetBill:
        return Color(0xFF52D5BA);
      case ExpensesCategory.salaries:
        return Color(0xFFFF4267);
      case ExpensesCategory.transportation:
        return Color(0xFFFFAF2A);
    }
  }

  String get amountSign {
  return this == ExpensesCategory.salaries ? '+' : '-';
}

Color get amountColor {
  return this == ExpensesCategory.salaries
      ? const Color(0xFF3629B7) 
      : const Color(0xFFFF4267); 
}

static ExpensesCategory fromString(String value) {
  return ExpensesCategory.values.firstWhere(
    (e) => e.name.toLowerCase() == value.toLowerCase(),
    orElse: () {
      debugPrint('Unknown category: $value. Defaulting to transportation.');
      return ExpensesCategory.transportation; 
    },
  );
}

  
}
