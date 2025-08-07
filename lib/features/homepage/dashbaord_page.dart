import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myflutterapp/enumClass/enum.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/cutom_toggle_switch_widget.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/screen_layout.dart';
import 'package:myflutterapp/features/homepage/screens/beneficiary/beneficiary.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card.dart';
import 'package:myflutterapp/features/auth/login/sign_in_page.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card_background_design.dart';
import 'package:myflutterapp/features/homepage/screens/transactions/transaction_report.dart';
import 'package:myflutterapp/features/widget/home_category_layout.dart';
import 'package:myflutterapp/features/widget/profile_user_img_widget.dart';
import 'package:myflutterapp/features/widget/profile_username_widget.dart';
import 'package:myflutterapp/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myflutterapp/theme/theme_preference.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenPage extends ConsumerStatefulWidget {
  const ScreenPage({super.key});

  @override
  ConsumerState<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends ConsumerState<ScreenPage> {
  User? currentUser;
  final SharedPrefService prefService = SharedPrefService();

    @override
  void initState() {
    super.initState();
    loadUserAndBalance();
    getUserExpenses();
  }

   Future<void> getUserExpenses() async {
    User? user = await prefService.getCurrentUser();
    if (user != null) {
      if (mounted){
        setState(() {
        currentUser = user;
      });
      }  
    }
  }

  String getMaskedCardNumber(String cardNumber) {
    String cleaned = cardNumber.replaceAll(' ', '');
    if (cleaned.length < 7) return cardNumber;

    String firstFour = cleaned.substring(0, 4);
    String lastThree = cleaned.substring(cleaned.length - 3);

    return '$firstFour  ****   $lastThree';
  }

  Future<void> loadUserAndBalance() async {
    await getCardBalanceAmount();
    User? user = await prefService.getCurrentUser();
    setState(() {
      currentUser = user;
    });
  }

  Future<void> getCardBalanceAmount() async {
    User? user = await prefService.getCurrentUser();
    if (user != null) {
      double balance = getTotalAmount(user);
      user.cardBalance = balance.abs().toStringAsFixed(2);
      await prefService.setData(user);
    }
  }

  double getTotalAmount(User user) {
    double total = 0.0;

    for (int i = 0; i < user.amount!.length; i++) {
      final amountString = user.amount![i];
      final categoryString = user.category![i];

      final categoryEnum = ExpensesCategoryExtension.fromString(categoryString);
      final parsedAmount = double.tryParse(amountString) ?? 0.0;

      if (categoryEnum == ExpensesCategory.salaries) {
        total += parsedAmount;
      } else {
        total -= parsedAmount;
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final loc = AppLocalizations.of(context)!;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        ScreenLayout(marginOfWhiteContainer: EdgeInsets.only(top: 130.h)),
        Align(
          alignment: Alignment.topLeft,
          child: ProfileUserImgWidget(
            imgHeight: 50.h,
            imgWidth: 50.w,
            imgMargin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 56.h),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 85.w, vertical: 69.h),
          child: ProfileUsernameWidget(
            username: loc.hiUser,
            txtColor: Theme.of(context).colorScheme.onPrimary,
            txtFontWeight: FontWeight.w500,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 88.w, vertical: 60.h),
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                final RenderBox button =
                    context.findRenderObject() as RenderBox;
                final RenderBox overlay =
                    Overlay.of(context).context.findRenderObject() as RenderBox;
                final Offset position = button.localToGlobal(
                  Offset.zero,
                  ancestor: overlay,
                );

                showMenu<Locale>(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    position.dx + button.size.width,
                    position.dy,
                    position.dx,
                    position.dy + button.size.height,
                  ),
                  items: [
                    PopupMenuItem(
                      value: const Locale('en'),
                      child: const Text('English'),
                    ),
                    PopupMenuItem(
                      value: const Locale('ne'),
                      child: const Text('Nepali'),
                    ),
                    PopupMenuItem(
                      value: const Locale('fr'),
                      child: const Text('French'),
                    ),
                  ],
                ).then((selectedLocale) {
                  if (selectedLocale != null) {
                    ref.read(localeProvider.notifier).state = selectedLocale;
                  }
                });
              },
              icon: Icon(Icons.g_translate_rounded, color: Colors.white),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 60.h),
          child: Align(
            alignment: Alignment.topRight,
            child: CutomToggleSwitchWidget(),
          ),
        ),
        GestureDetector(
          onTap: () async {
            final prefService = SharedPrefService();
            await prefService.clearData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => SignInPage()),
              (route) => false,
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.08,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                'assets/icon/notify_bell.svg',
                height: 28.h,
                width: 26.w,
              ),
            ),
          ),
        ),

        Positioned(
          top: 130.h,
          child: CreditCardBackgroundDesign(

            // cardNumber:getMaskedCardNumber(currentUser!.cardNumber ?? '123214123'),
          ),
        ),

        Positioned(
          top: 391.h,
          left: 24.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  HomeCategoryLayout(
                    text: loc.accountAndCard,
                    iconImg: 'assets/icon/home_icon/accountCard.svg',
                  ),

                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: loc.transfer,
                    iconImg: 'assets/icon/home_icon/transfer.svg',
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: loc.withdraw,
                    iconImg: 'assets/icon/home_icon/withdraw.svg',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  HomeCategoryLayout(
                    text: loc.mobilePrepaid,
                    iconImg: 'assets/icon/home_icon/mobilePrepaid.svg',
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: loc.payTheBill,
                    iconImg: 'assets/icon/home_icon/receipt.svg',
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: loc.saveOnline,
                    iconImg: 'assets/icon/home_icon/pig.svg',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  HomeCategoryLayout(
                    text: loc.creditCard,
                    iconImg: 'assets/icon/home_icon/creditCard.svg',
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreditCard()),
                      );
                    },
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: loc.transactionReport,
                    iconImg: 'assets/icon/home_icon/report.svg',
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionReport(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: loc.beneficiary,
                    iconImg: 'assets/icon/home_icon/beneficiary.svg',
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Beneficiary()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
