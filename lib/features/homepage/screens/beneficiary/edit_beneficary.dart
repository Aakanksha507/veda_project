import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myflutterapp/features/auth/sevice/input_validation.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/custom_button_widget.dart';
import 'package:myflutterapp/features/homepage/home_screen.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card.dart';
import 'package:myflutterapp/features/widget/profile_user_img_widget.dart';
import 'package:myflutterapp/features/widget/profile_username_widget.dart';
import 'package:myflutterapp/features/widget/text_field_widget/input_fiels_widget.dart';
import 'package:myflutterapp/models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'package:myflutterapp/AppColor/app_color.dart';

class EditBeneficary extends StatefulWidget {
  final String bankName;
  final String branchName;
  final String transactionName;
  final String cardNumber;

  const EditBeneficary({
    super.key,
    required this.bankName,
    required this.branchName,
    required this.transactionName,
    required this.cardNumber,
  });

  @override
  State<EditBeneficary> createState() => _EditBeneficaryState();
}

class _EditBeneficaryState extends State<EditBeneficary> {
  late TextEditingController bankNameController;
  late TextEditingController bankBranchController;
  late TextEditingController transactionNameController;
  late TextEditingController cardNumberController;

  final bankNameNode = FocusNode();
  final bankBranchNode = FocusNode();
  final transactionNameNode = FocusNode();
  final cardNumberNode = FocusNode();

  final SharedPrefService prefService = SharedPrefService();
  final uuid = Uuid();
  final _formkey = GlobalKey<FormState>();

  String? bankNameError;
  String? branchNameError;
  String? transactionNameError;
  String? cardNumberError;

  bool isEdited = false;

  // for cardNumber Formatter
  final cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### ###',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    bankNameController = TextEditingController(text: widget.bankName);
    bankBranchController = TextEditingController(text: widget.branchName);
    transactionNameController = TextEditingController(
      text: widget.transactionName,
    );
    cardNumberController = TextEditingController(text: widget.cardNumber);

    bankNameController.addListener(checkedEditedorNot);
    bankBranchController.addListener(checkedEditedorNot);
    transactionNameController.addListener(checkedEditedorNot);
    cardNumberController.addListener(checkedEditedorNot);
  }

  void checkedEditedorNot() {
    final bankname = bankNameController.text.trim();
    final bankBranch = bankBranchController.text.trim();
    final transactionName = transactionNameController.text.trim();
    final cardNumber = cardNumberController.text.trim();

    bool edited =
        bankname != widget.bankName.trim() ||
        bankBranch != widget.branchName.trim() ||
        transactionName != widget.transactionName.trim() ||
        cardNumber != widget.cardNumber.trim();

    if (edited != isEdited) {
      setState(() {
        isEdited = edited;
      });
    }
  }

  @override
  void dispose() {
    bankNameController.dispose();
    bankBranchController.dispose();
    transactionNameController.dispose();
    cardNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(
          mainTxt: 'Edit Beneficiary',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        backgroundColor:  AppColor.primary1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 375.w,
                    height: 700.h,
                    decoration: BoxDecoration(color: AppColor.primary1),
                    child: Container(
                      height: 641.h,
                      width: 375.w,
                      margin: EdgeInsets.only(top: 78.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                    ),
                  ),

                  Positioned(child: ProfileUserImgWidget()),
                  Positioned(
                    top: 127.h,
                    left: 125.w,
                    child: ProfileUsernameWidget(username: "Push Puttichai"),
                  ),

                  Positioned(
                    top: 160.h,
                    left: 24.w,
                    right: 24.w,
                    child: Container(
                      height: 641.h,
                      decoration: BoxDecoration(
                        color: AppColor.neutral6,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 30,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InputFielsWidget(
                              focusNode: bankNameNode,
                              controller: bankNameController,
                              validator: InputValidation.validateBankName,
                              errorText: bankNameError,
                              labelTxt: 'Choose Bank',
                              hintTxt: 'Choose Bank',
                            ),

                            InputFielsWidget(
                              focusNode: bankBranchNode,
                              labelTxt: 'Choose branch',
                              controller: bankBranchController,
                              validator: InputValidation.validateBranchName,
                              errorText: branchNameError,
                              hintTxt: 'Choose branch',
                            ),

                            InputFielsWidget(
                              labelTxt: 'Transaction name',
                              controller: transactionNameController,
                              focusNode: transactionNameNode,
                              validator:
                                  InputValidation.validateTransactionName,
                              hintTxt: 'Transaction name',
                            ),

                            InputFielsWidget(
                              labelTxt: 'Card number',
                              controller: cardNumberController,
                              focusNode: cardNumberNode,
                              validator: InputValidation.validateCardNumber,
                              errorText: cardNumberError,
                              inputFormatters: [cardNumberFormatter],
                              hintTxt: 'Card number',
                              keyboardType: TextInputType.number,
                            ),

                            SizedBox(height: 24.h),

                            Padding(
                              padding: EdgeInsets.only(
                                top: 16.h,
                                left: 16.w,
                                right: 16.w,
                              ),
                              child: CustomButtonWidget(
                                btnText: "Edit",
                                bgColorBtn: AppColor.primary1,
                                onTap:
                                    isEdited
                                        ? () async {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            final bankName =
                                                bankNameController.text.trim();
                                            final bankBranch =
                                                bankBranchController.text
                                                    .trim();
                                            final transactionName =
                                                transactionNameController.text
                                                    .trim();
                                            final entercardNumber =
                                                cardNumberController.text
                                                    .trim();

                                            final bankNameErrorText =
                                                InputValidation.validateBankName(
                                                  bankName,
                                                );
                                            final branchNameErrorText =
                                                InputValidation.validateBranchName(
                                                  bankBranch,
                                                );
                                            final transactionNameErrorText =
                                                InputValidation.validateTransactionName(
                                                  transactionName,
                                                );
                                            final cardNumberErrorText =
                                                InputValidation.validateCardNumber(
                                                  entercardNumber,
                                                );

                                            setState(() {
                                              bankNameError = bankNameErrorText;
                                              branchNameError =
                                                  branchNameErrorText;
                                              transactionNameError =
                                                  transactionNameErrorText;
                                              cardNumberError =
                                                  cardNumberErrorText;
                                            });

                                            final currentUser =
                                                await prefService
                                                    .getCurrentUser();

                                            if (currentUser != null) {
                                              final updateUser = User(
                                                id: currentUser.id,
                                                phoneNumber:
                                                    currentUser.phoneNumber,
                                                bankName:
                                                    bankNameController.text
                                                        .trim(),
                                                bankBranch:
                                                    bankBranchController.text
                                                        .trim(),
                                                transactionName:
                                                    transactionNameController
                                                        .text
                                                        .trim(),
                                                cardNumber:
                                                    cardNumberController.text
                                                        .trim(),
                                              );

                                              await prefService.setData(
                                                updateUser,
                                              );
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Updated Beneficary Succcessfully",
                                                  ),
                                                ),
                                              );

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) => const CreditCard(),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
