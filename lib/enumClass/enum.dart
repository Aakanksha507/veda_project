
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
enum ExpensesCategory{
   
   WaterBill,
   ElectricityBill,
   InternetBill,
   Salaries,
   Transportation,
  
}

extension ExpensesCategoryExtension on ExpensesCategory {
  String get label {
    switch (this) {
      case ExpensesCategory.WaterBill:
        return "Water Bill";
      case ExpensesCategory.ElectricityBill:
        return "Electricity Bill";
      case ExpensesCategory.InternetBill:
        return "Internet Bill";
      case ExpensesCategory.Salaries:
        return "Salaries";
      case ExpensesCategory.Transportation:
        return "Transportation";
    }
  }

  // String get svgAsset {
  //   switch (this) {
  //     case ExpensesCategory.WaterBill:
  //       return  ;
  //     case ExpensesCategory.ElectricityBill:
        
  //     case ExpensesCategory.InternetBill:
      
  //     case ExpensesCategory.Salaries:
        
  //     case ExpensesCategory.Transportation:
       
  //   }
  // }

  // double get amount {
  //   switch (this) {
  //     case ExpensesCategory.WaterBill:
  //       return amount;
  //     case ExpensesCategory.ElectricityBill:
  //       return amount;
  //     case ExpensesCategory.InternetBill:
  //       return amount;
  //     case ExpensesCategory.Salaries:
  //       return -amount;
  //     case ExpensesCategory.Transportation:
  //       return -amount;
  //   }
  // }

  // Color get amountColor {
  //   return amount >= 0 ? Colors.red : Colors.purple;
  // }
}
