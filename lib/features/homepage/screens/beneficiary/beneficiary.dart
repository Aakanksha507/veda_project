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
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          MaterialPageRoute(
            builder:
                (context) => EditBeneficary(
                  bankName: currentUser.bankName ?? '',
                  branchName: currentUser.bankBranch ?? '',
                  transactionName: currentUser.transactionName ?? '',
                  cardNumber: currentUser.cardNumber ?? '',
                ),
          ),
        );
      });
    } else {
      setState(() {
        _isRedirecting = false;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  // Card number formatter
  final cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### ###',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    bankNameController.dispose();
    bankBranchController.dispose();
    transactionNameController.dispose();
    cardNumberController.dispose();
    bankNameNode.dispose();
    bankBranchNode.dispose();
    transactionNameNode.dispose();
    cardNumberNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (_isRedirecting) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(mainTxt: loc.beneficiary),
        backgroundColor:Theme.of(context).primaryColor,
      ),
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 375.w,
                      height: 700.h,
                      decoration: BoxDecoration(color:Theme.of(context).primaryColor),
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
                      left: 145.w,
                      child: ProfileUsernameWidget(username: loc.user),
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
                              color: const Color(0x0D000000),
                              blurRadius: 30,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InputFielsWidget(
                                focusNode: bankNameNode,
                                controller: bankNameController,
                                validator:
                                    (value) => InputValidation.validateBankName(
                                      loc,
                                      value,
                                    ),
                                labelTxt: loc.chooseBank,
                                hintTxt: loc.chooseBank,
                              ),
                              InputFielsWidget(
                                focusNode: bankBranchNode,
                                labelTxt: loc.chooseBranch,
                                controller: bankBranchController,
                                validator:
                                    (value) => InputValidation.validateBranchName(
                                      loc,
                                      value,
                                    ),
                                hintTxt: loc.chooseBranch,
                              ),
                              InputFielsWidget(
                                labelTxt: loc.transactionName,
                                controller: transactionNameController,
                                focusNode: transactionNameNode,
                                validator:
                                    (value) =>
                                        InputValidation.validateTransactionName(
                                          loc,
                                          value,
                                        ),
                                hintTxt: loc.transactionName,
                              ),
                              InputFielsWidget(
                                labelTxt: loc.cardNumber,
                                controller: cardNumberController,
                                focusNode: cardNumberNode,
                                validator:
                                    (value) => InputValidation.validateCardNumber(
                                      loc,
                                      value,
                                    ),
                                inputFormatters: [cardNumberFormatter],
                                hintTxt: loc.cardNumber,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 24.h),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                                child: CustomButtonWidget(
                                  btnText: loc.confirm,
                                  bgColorBtn: AppColor.primary1,
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final bankName =
                                          bankNameController.text.trim();
                                      final bankBranch =
                                          bankBranchController.text.trim();
                                      final transactionName =
                                          transactionNameController.text.trim();
                                      final entercardNumber =
                                          cardNumberController.text.trim();
        
                                      final currentUser =
                                          await prefService.getCurrentUser();
                                      if (currentUser != null) {
                                        final updateUser = User(
                                          id: currentUser.id,
                                          username: currentUser.username,
                                          phoneNumber: currentUser.phoneNumber,
                                          password: currentUser.password,
                                          profileImg: currentUser.profileImg,
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
      ),
    );
  }
}
