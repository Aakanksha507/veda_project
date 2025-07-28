import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/enumClass/enum.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/custom_button_widget.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/transactions/transaction_report.dart';
import 'package:myflutterapp/features/widget/text_field_widget/dropdown_field_widget.dart';
import 'package:myflutterapp/features/widget/text_field_widget/input_fiels_widget.dart';

class EditExpenses extends StatefulWidget {

final String category;
final String description;
final String amount;
final int index;

  const EditExpenses({super.key,
   required this.category,
    required this.description,
     required this.amount, 
     required this.index
     });

  @override
  State<EditExpenses> createState() => _EditExpensesState();
}

class _EditExpensesState extends State<EditExpenses> {
  late TextEditingController descriptionController;
  late TextEditingController amountController;
  String? selectedValue;

  SharedPrefService prefService = SharedPrefService();

@override
void initState(){
  super.initState();
  descriptionController = TextEditingController(text: widget.description);
  amountController = TextEditingController(text: widget.amount);
  selectedValue = widget.category;
}

@override
void dispose(){
  setState(() {
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(
          mainTxt: "Edit Expenses",
          bgColor: Color(0xFF3629B7),
          txtColor: Color(0xFFFFFFFF),
          iconColor: Color(0xFFFFFFFF),
        ),
        backgroundColor: Color(0xFF3629B7),
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropdownFieldWidget(
              selectedValue:
                  selectedValue != null
                      ? ExpensesCategory.values.firstWhere(
                        (e) => e.name == selectedValue,
                      )
                      : null,
              onChanged: (value) {
                setState(() {
                  selectedValue = value?.name;
                });
              },
            ),
            InputFielsWidget(
              hintTxt: 'Description',
              focusNode: FocusNode(),
              labelTxt: 'Description',
              controller: descriptionController,
            ),
            InputFielsWidget(
              hintTxt: 'Amount',
              focusNode: FocusNode(),
              labelTxt: 'Amount',
              controller: amountController,
            ),
            Padding(
              padding: EdgeInsets.all(55.w),
              child: CustomButtonWidget(
                btnText: 'Edit Expenses',
                bgColorBtn: Color(0xFF3629B7),
                onTap: () async{
                  final description = descriptionController.text.trim();
                  final amount = amountController.text.trim();
                  final currentUser = await prefService.getCurrentUser();

                  if (currentUser != null) {
                
                    currentUser.category![widget.index] = selectedValue ?? widget.category;
                    currentUser.description![widget.index] = description;
                    currentUser.amount![widget.index] = amount;
                  
                  await prefService.setData(currentUser);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Add Expenses Succcessfully")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionReport(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
