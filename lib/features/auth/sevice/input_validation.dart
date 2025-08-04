import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputValidation {
  static String? validatePhoneNumber(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return loc.phone_required;
    }
    if (value.length < 10) {
      return loc.phone_min_length;
    }
    return null;
  }

  static String? validatePassword(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return loc.password_required;
    }
    if (value.length < 6) {
      return  loc.password_min_length;
    }
    return null;
  }

  static String? validateUserName(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return loc.username_required;
    }
    if (value.length < 3) {
      return loc.username_min_length;
    }
    return null;
  }

  static String? validateBankName(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return loc.bankname_required;
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value.trim())) {
      return loc.alphabetic_only;
    }
    return null;
  }

  static String? validateBranchName(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return loc.branch_required;
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value.trim())) {
      return loc.alphabetic_only;
    }
    return null;
  }

  static String? validateTransactionName(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return loc.transaction_requirded;
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value.trim())) {
      return loc.alphabetic_only;
    }
    return null;
  }

  static String? validateCardNumber(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return loc.cardnumber_required;
    }
    return null;
  }

  static String? validateDescription(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return loc.description_required;
    }
    return null;
  }

  static String? validateAmount(AppLocalizations loc, String? value) {
    if (value == null || value.trim().isEmpty) {
      return loc.amount_required;
    }
    return null;
  }
}
