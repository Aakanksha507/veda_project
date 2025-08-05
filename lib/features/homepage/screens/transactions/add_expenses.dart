import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/enumClass/enum.dart';
import 'package:myflutterapp/features/auth/sevice/input_validation.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/custom_button_widget.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/transactions/transaction_report.dart';
import 'package:myflutterapp/features/widget/text_field_widget/dropdown_field_widget.dart';
import 'package:myflutterapp/features/widget/text_field_widget/input_fiels_widget.dart';
import 'package:myflutterapp/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final descriptionController = TextEditingController();
  final amoutController = TextEditingController();

  final SharedPrefService prefService = SharedPrefService();

  String? selectedValue;

  final _formkey = GlobalKey<FormState>();
  String? descriptionError;
  String? amountError;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(
          mainTxt: loc.addExpenses,
          bgColor:Theme.of(context).primaryColor,
          txtColor: Color(0xFFFFFFFF),
          iconColor: Color(0xFFFFFFFF),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransactionReport()),
            );
          },
        ),
        backgroundColor:Theme.of(context).primaryColor,
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        child: Form(
          key: _formkey,
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
                hintTxt: loc.description,
                validator: (value) => InputValidation.validateDescription(loc, value),
                focusNode: FocusNode(),
                controller: descriptionController,
                labelTxt: loc.description,
              ),
              InputFielsWidget(
                hintTxt: loc.amount,
                controller: amoutController,
                validator: (value) => InputValidation.validateAmount(loc, value),
                focusNode: FocusNode(),
                labelTxt: loc.amount,
              ),
              Padding(
                padding: EdgeInsets.all(55.w),
                child: CustomButtonWidget(
                  btnText: loc.addExpenses,
                  bgColorBtn: Theme.of(context).primaryColor,
                  onTap: () async {
                    if (_formkey.currentState!.validate()) {
                      final description = descriptionController.text.trim();
                      final amount = amoutController.text.trim();
                      final currentUser = await prefService.getCurrentUser();

                      final descriptionErrorText =
                          InputValidation.validateBankName(loc, description);
                      final amountErrorText =
                          InputValidation.validateBranchName(loc, amount);

                      setState(() {
                        descriptionError = descriptionErrorText;
                        amountError = amountErrorText;
                      });

                      if (currentUser != null) {
                        final updatedDescriptionList = List<String>.from(
                          currentUser.description ?? [],
                        )..add(description);
                        final updatedAmountList = List<String>.from(
                          currentUser.amount ?? [],
                        )..add(amount);
                        final updatedCategoryList = List<String>.from(
                          currentUser.category ?? [],
                        )..add(selectedValue ?? '');

                        final updateWithCategory = User(
                          id: currentUser.id,
                          username: currentUser.username,
                          phoneNumber: currentUser.phoneNumber,
                          password: currentUser.password,
                          bankName: currentUser.bankName,
                          bankBranch: currentUser.bankBranch,
                          transactionName: currentUser.transactionName,
                          cardNumber: currentUser.cardNumber,
                          category: updatedCategoryList,
                          description: updatedDescriptionList,
                          amount: updatedAmountList,
                        );

                        // debugPrint('Amoutn: ${updateWithCategory.amount}');

                        await prefService.setData(updateWithCategory);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(loc.add_successfully)),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionReport(),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
