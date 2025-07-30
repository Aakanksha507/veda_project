import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myflutterapp/features/auth/sevice/input_validation.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/custom_button_widget.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/beneficiary/edit_beneficary.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card.dart';
import 'package:myflutterapp/features/widget/text_field_widget/input_fiels_widget.dart';
import 'package:myflutterapp/features/widget/profile_user_img_widget.dart';
import 'package:myflutterapp/features/widget/profile_username_widget.dart';
import 'package:myflutterapp/models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'package:myflutterapp/AppColor/app_color.dart';

class Beneficiary extends StatefulWidget {
  const Beneficiary({super.key});

  @override
  State<Beneficiary> createState() => _BeneficiaryState();
}

class _BeneficiaryState extends State<Beneficiary> {
  final bankNameController = TextEditingController();
  final bankBranchController = TextEditingController();
  final transactionNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final bankNameNode = FocusNode();
  final bankBranchNode = FocusNode();
  final transactionNameNode = FocusNode();
  final cardNumberNode = FocusNode();
  final SharedPrefService prefService = SharedPrefService();

  bool _isRedirecting = true;

  @override
  void initState() {
    super.initState();
    _checkExistingCard();
  }

  Future<void> _checkExistingCard() async {
    final currentUser = await prefService.getCurrentUser();
    if (currentUser != null &&
        currentUser.cardNumber != null &&
        currentUser.cardNumber!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EditBeneficary( 
              bankName: currentUser.bankName ?? '',
              branchName: currentUser.bankBranch ?? '',
              transactionName: currentUser.transactionName ?? '',
              cardNumber: currentUser.cardNumber ?? '',
          )),
        );
      });
    }
    setState(() {
      _isRedirecting = true;
    });
  }

  final uuid = Uuid();

  final _formkey = GlobalKey<FormState>();
  String? bankNameError;
  String? branchNameError;
  String? transactionNameError;
  String? cardNumberError;

  // for cardNumber Formatter
  final cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### ###',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    if (_isRedirecting) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(mainTxt: 'Beneficiary'),
        backgroundColor: AppColor.primary1,
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
                        color: AppColor.neutral6,
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
          
                  // SizedBox(height: 12,),
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
                                btnText: "Confirm",
                                bgColorBtn: AppColor.primary1,
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    final bankName =
                                        bankBranchController.text.trim();
                                    final bankBranch =
                                        bankBranchController.text.trim();
                                    final transactionName =
                                        transactionNameController.text.trim();
                                    final entercardNumber =
                                        cardNumberController.text.trim();
          
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
                                      branchNameError = branchNameErrorText;
                                      transactionNameError =
                                          transactionNameErrorText;
                                      cardNumberError = cardNumberErrorText;
                                    });
          
                                    final currentUser =
                                        await prefService.getCurrentUser();
                                    if (currentUser != null) {
                                      final updateUser = User(
                                        id: currentUser.id,
                                        username: currentUser.username,
                                        phoneNumber: currentUser.phoneNumber,
                                        password: currentUser.password,
                                        bankName: bankName,
                                        bankBranch: bankBranch,
                                        transactionName: transactionName,
                                        cardNumber: entercardNumber,
                                      );
          
                                      await prefService.setData(updateUser);
          
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const CreditCard(),
                                        ),
                                      );
                                    }
                                  }
                                  ;
                                },
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
