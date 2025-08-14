import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/enumClass/enum.dart';
import 'package:myflutterapp/features/auth/sevice/input_validation.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/custom_button_widget.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/transactions/transaction_report.dart';
import 'package:myflutterapp/features/utils/custom_snack_bar.dart';
import 'package:myflutterapp/features/widget/text_field_widget/dropdown_field_widget.dart';
import 'package:myflutterapp/features/widget/text_field_widget/input_fiels_widget.dart';
import 'package:myflutterapp/l10n/app_localizations.dart';

class EditExpenses extends StatefulWidget {
  final String category;
  final String description;
  final String amount;
  final int index;

  const EditExpenses({
    super.key,
    required this.category,
    required this.description,
    required this.amount,
    required this.index,
  });

  @override
  State<EditExpenses> createState() => _EditExpensesState();
}

class _EditExpensesState extends State<EditExpenses> {
  late TextEditingController descriptionController;
  late TextEditingController amountController;
  String? selectedValue;
  bool isEdited = false;

  SharedPrefService prefService = SharedPrefService();

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController(text: widget.description);
    amountController = TextEditingController(text: widget.amount);
    selectedValue = widget.category;

    descriptionController.addListener(checkedEditedorNot);
    amountController.addListener(checkedEditedorNot);
  }

  void checkedEditedorNot() {
    final description = descriptionController.text.trim();
    final amount = amountController.text.trim(); //removing whitespace
    final categorySelected =
        selectedValue !=
        widget.category; //comparing with original selected value

    bool edited = // checking any line is been edited
        description != widget.description.trim() ||
        amount != widget.amount.trim() ||
        categorySelected;
    if (edited != isEdited) {
      setState(() {
        isEdited = edited;
      });
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

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
          mainTxt: loc.editExpenses,
          bgColor: Theme.of(context).primaryColor,
          txtColor: Color(0xFFFFFFFF),
          iconColor: Color(0xFFFFFFFF),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransactionReport()),
            );
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
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
                  checkedEditedorNot();
                },
              ),
              InputFielsWidget(
                hintTxt: loc.description,
                focusNode: FocusNode(),
                validator: (value) => InputValidation.validateDescription(loc, value),
                labelTxt: loc.description,
                controller: descriptionController,
              ),
              InputFielsWidget(
                hintTxt: loc.amount,
                validator: (value) => InputValidation.validateAmount(loc, value),
                focusNode: FocusNode(),
                labelTxt: loc.amount,
                controller: amountController,
              ),
              Padding(
                padding: EdgeInsets.all(55.w),
                child: CustomButtonWidget(
                  btnText:  loc.editExpenses,
                  bgColorBtn: Theme.of(context).primaryColor,
                  onTap:
                      isEdited
                          ? () async {
                            if (_formkey.currentState!.validate()) {
                              final description =
                                  descriptionController.text.trim();
                              final amount = amountController.text.trim();

                              final descriptionErrorText =
                                  InputValidation.validateBankName(loc, description);
                              final amountErrorText =
                                  InputValidation.validateBranchName(loc, amount);

                              setState(() {
                                descriptionError = descriptionErrorText;
                                amountError = amountErrorText;
                              });

                              final currentUser =
                                  await prefService.getCurrentUser();

                              if (currentUser != null) {
                                currentUser.category![widget.index] =
                                    selectedValue ?? widget.category;
                                currentUser.description![widget.index] =
                                    description;
                                currentUser.amount![widget.index] = amount;

                                await prefService.setData(currentUser);
                                 CustomSnackBar.show(context, loc.update_successfully);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TransactionReport(),
                                  ),
                                );
                              }
                            }
                          }
                          : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
