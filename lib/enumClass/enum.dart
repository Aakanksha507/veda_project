import 'package:flutter/material.dart';
import 'package:myflutterapp/AppColor/app_color.dart';

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
        return AppColor.primary1;
      case ExpensesCategory.electricityBill:
        return AppColor.semantic2;
      case ExpensesCategory.internetBill:
        return AppColor.semantic4;
      case ExpensesCategory.salaries:
        return AppColor.semantic1;
      case ExpensesCategory.transportation:
        return AppColor.semantic3;
    }
  }

  String get amountSign {
  return this == ExpensesCategory.salaries ? '+' : '-';
}

Color? get amountColor {
  return this == ExpensesCategory.salaries
      ? AppColor.primary1 
      :  AppColor.semantic1; 
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
