import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ne.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('ne'),
  ];

  /// No description provided for @hiUser.
  ///
  /// In en, this message translates to:
  /// **'Hi, John Smith'**
  String get hiUser;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'John Smith'**
  String get user;

  /// No description provided for @amazonPlatinium.
  ///
  /// In en, this message translates to:
  /// **'Amazon Platinium'**
  String get amazonPlatinium;

  /// No description provided for @accountAndCard.
  ///
  /// In en, this message translates to:
  /// **'Account and Card'**
  String get accountAndCard;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @mobilePrepaid.
  ///
  /// In en, this message translates to:
  /// **'Mobile prepaid'**
  String get mobilePrepaid;

  /// No description provided for @payTheBill.
  ///
  /// In en, this message translates to:
  /// **'Pay the bill'**
  String get payTheBill;

  /// No description provided for @saveOnline.
  ///
  /// In en, this message translates to:
  /// **'Save online'**
  String get saveOnline;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get creditCard;

  /// No description provided for @transactionReport.
  ///
  /// In en, this message translates to:
  /// **'Transaction Report'**
  String get transactionReport;

  /// No description provided for @beneficiary.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary'**
  String get beneficiary;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @bankOfAmerica.
  ///
  /// In en, this message translates to:
  /// **'Bank of America'**
  String get bankOfAmerica;

  /// No description provided for @bankOfAmericaSecondaryText.
  ///
  /// In en, this message translates to:
  /// **'Bank of America : 256486 is the au djk,fnbdskjfsjdfjsdbnsdfjksdnfsjdkkds..'**
  String get bankOfAmericaSecondaryText;

  /// No description provided for @date_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get date_today;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @accountSecondaryText.
  ///
  /// In en, this message translates to:
  /// **'Your account is limited. Please foll..'**
  String get accountSecondaryText;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alert;

  /// No description provided for @alertSecondaryText.
  ///
  /// In en, this message translates to:
  /// **'Your statement is ready for you to..'**
  String get alertSecondaryText;

  /// No description provided for @paypal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get paypal;

  /// No description provided for @paypalSecondaryText.
  ///
  /// In en, this message translates to:
  /// **'Your account has been locked..'**
  String get paypalSecondaryText;

  /// No description provided for @withdrawSecondaryText.
  ///
  /// In en, this message translates to:
  /// **'Dear customer, 2987456 is your co...'**
  String get withdrawSecondaryText;

  /// No description provided for @date_12_10.
  ///
  /// In en, this message translates to:
  /// **'10/12'**
  String get date_12_10;

  /// No description provided for @date_11_10.
  ///
  /// In en, this message translates to:
  /// **'10/11'**
  String get date_11_10;

  /// No description provided for @date_10_11.
  ///
  /// In en, this message translates to:
  /// **'11/10'**
  String get date_10_11;

  /// No description provided for @date_10_12.
  ///
  /// In en, this message translates to:
  /// **'12/10'**
  String get date_10_12;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @touchId.
  ///
  /// In en, this message translates to:
  /// **'Touch Id'**
  String get touchId;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @appInformation.
  ///
  /// In en, this message translates to:
  /// **'App information'**
  String get appInformation;

  /// No description provided for @customerCare.
  ///
  /// In en, this message translates to:
  /// **'Customer care'**
  String get customerCare;

  /// No description provided for @number_1233434.
  ///
  /// In en, this message translates to:
  /// **'1233434'**
  String get number_1233434;

  /// No description provided for @buyCamera.
  ///
  /// In en, this message translates to:
  /// **'BuyCamera'**
  String get buyCamera;

  /// No description provided for @buyTelevision.
  ///
  /// In en, this message translates to:
  /// **'Buy Television'**
  String get buyTelevision;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @addExpenses.
  ///
  /// In en, this message translates to:
  /// **'Add Expenses'**
  String get addExpenses;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get select;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'amount'**
  String get amount;

  /// No description provided for @waterBill.
  ///
  /// In en, this message translates to:
  /// **'Water Bill'**
  String get waterBill;

  /// No description provided for @electricityBill.
  ///
  /// In en, this message translates to:
  /// **'Electricity Bill'**
  String get electricityBill;

  /// No description provided for @internetBill.
  ///
  /// In en, this message translates to:
  /// **'Internet Bil'**
  String get internetBill;

  /// No description provided for @salaries.
  ///
  /// In en, this message translates to:
  /// **'Salaries'**
  String get salaries;

  /// No description provided for @transportation.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get transportation;

  /// No description provided for @editExpenses.
  ///
  /// In en, this message translates to:
  /// **'Edit Expenses'**
  String get editExpenses;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @signin.
  ///
  /// In en, this message translates to:
  /// **'SignIn'**
  String get signin;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @helloSignInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Hello there, sign in to continue'**
  String get helloSignInToContinue;

  /// No description provided for @forgetYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget your Password'**
  String get forgetYourPassword;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAnAccount;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up '**
  String get signup;

  /// No description provided for @welcomeToUs.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Us'**
  String get welcomeToUs;

  /// No description provided for @helloCreateNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Hello there, create New account'**
  String get helloCreateNewAccount;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @haveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get haveAnAccount;

  /// No description provided for @byCreatingAnAccountYourAgree.
  ///
  /// In en, this message translates to:
  /// **'By creating an account your agree'**
  String get byCreatingAnAccountYourAgree;

  /// No description provided for @toOur.
  ///
  /// In en, this message translates to:
  /// **'to our'**
  String get toOur;

  /// No description provided for @termCondtions.
  ///
  /// In en, this message translates to:
  /// **' Term and Condtions'**
  String get termCondtions;

  /// No description provided for @editBeneficary.
  ///
  /// In en, this message translates to:
  /// **'Edit Beneficary'**
  String get editBeneficary;

  /// No description provided for @chooseBank.
  ///
  /// In en, this message translates to:
  /// **'Choose Bank'**
  String get chooseBank;

  /// No description provided for @chooseBranch.
  ///
  /// In en, this message translates to:
  /// **'Choose branch'**
  String get chooseBranch;

  /// No description provided for @transactionName.
  ///
  /// In en, this message translates to:
  /// **'Transaction name'**
  String get transactionName;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get cardNumber;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @beneficary.
  ///
  /// In en, this message translates to:
  /// **'Beneficary'**
  String get beneficary;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon !'**
  String get comingSoon;

  /// No description provided for @registration_success_message.
  ///
  /// In en, this message translates to:
  /// **'User Register Succesfully'**
  String get registration_success_message;

  /// No description provided for @invalid_phone_password_message.
  ///
  /// In en, this message translates to:
  /// **'Invalid Phone Number or Password'**
  String get invalid_phone_password_message;

  /// No description provided for @invalid_phone_message.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Phone Number.'**
  String get invalid_phone_message;

  /// No description provided for @invalid_password_message.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Password.'**
  String get invalid_password_message;

  /// No description provided for @phone_required.
  ///
  /// In en, this message translates to:
  /// **'Phone Number is Required'**
  String get phone_required;

  /// No description provided for @phone_min_length.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be at least 10 digits'**
  String get phone_min_length;

  /// No description provided for @password_required.
  ///
  /// In en, this message translates to:
  /// **'Password is Required'**
  String get password_required;

  /// No description provided for @password_min_length.
  ///
  /// In en, this message translates to:
  /// **' Password must be at least 6'**
  String get password_min_length;

  /// No description provided for @username_required.
  ///
  /// In en, this message translates to:
  /// **'UserName is Required'**
  String get username_required;

  /// No description provided for @username_min_length.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3'**
  String get username_min_length;

  /// No description provided for @bankname_required.
  ///
  /// In en, this message translates to:
  /// **'BankName is Required'**
  String get bankname_required;

  /// No description provided for @alphabetic_only.
  ///
  /// In en, this message translates to:
  /// **'Only alphabetic characters are allowed'**
  String get alphabetic_only;

  /// No description provided for @branch_required.
  ///
  /// In en, this message translates to:
  /// **'Branch Name is Required'**
  String get branch_required;

  /// No description provided for @cardnumber_required.
  ///
  /// In en, this message translates to:
  /// **'CardNumber is Required'**
  String get cardnumber_required;

  /// No description provided for @description_required.
  ///
  /// In en, this message translates to:
  /// **'Description is Required'**
  String get description_required;

  /// No description provided for @transaction_requirded.
  ///
  /// In en, this message translates to:
  /// **'Transaction Name is Required'**
  String get transaction_requirded;

  /// No description provided for @amount_required.
  ///
  /// In en, this message translates to:
  /// **'Amount is Required'**
  String get amount_required;

  /// No description provided for @update_successfully.
  ///
  /// In en, this message translates to:
  /// **' Updated Sucessfully'**
  String get update_successfully;

  /// No description provided for @category_required.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get category_required;

  /// No description provided for @add_successfully.
  ///
  /// In en, this message translates to:
  /// **'Added Successfully'**
  String get add_successfully;

  /// No description provided for @deleted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Deleted Successfully'**
  String get deleted_successfully;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ne':
      return AppLocalizationsNe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
