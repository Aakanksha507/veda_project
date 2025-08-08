import 'package:flutter/material.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


enum ExpensesCategory {
  waterBill,
  electricityBill,
  internetBill,
  salaries,
  transportation,
  debtClerance
}

extension ExpensesCategoryExtension on ExpensesCategory {
  String label (BuildContext context){
  final loc = AppLocalizations.of(context)!;
    switch (this) {
      case ExpensesCategory.waterBill:
        return loc.waterBill;
      case ExpensesCategory.electricityBill:
        return loc.electricityBill;
      case ExpensesCategory.internetBill:
        return loc.internetBill;
      case ExpensesCategory.salaries:
        return loc.salaries;
      case ExpensesCategory.transportation:
        return loc.transportation;
      case ExpensesCategory.debtClerance:
        return "Debt Clearance";
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
      case ExpensesCategory.debtClerance:
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
      case ExpensesCategory.debtClerance:
        return AppColor.semantic5; 
    }
  }

//   String get amountSign {
//   return this == ExpensesCategory.salaries ? '+' : '-';
// }

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
