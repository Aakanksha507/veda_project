import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/enumClass/enum.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';
import 'package:myflutterapp/l10n/app_localizations.dart';

class DropdownFieldWidget extends StatefulWidget {
  final ExpensesCategory? selectedValue;
  final ValueChanged<ExpensesCategory?> onChanged;


  const DropdownFieldWidget({
    super.key,
    required this.onChanged,
    this.selectedValue,

  });

  @override
  State<DropdownFieldWidget> createState() => _DropdownFieldWidgetState();
}

class _DropdownFieldWidgetState extends State<DropdownFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(top: 24.w, left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.h),
            child: TextWidget(
              txt: loc.category,
              fontWeight: FontWeight.w600,
              txtColor: Color(0xFF979797),
              fontSize: 12.sp,
            ),
          ),
          DropdownButtonFormField<ExpensesCategory>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xFFCACACA)),
              ),
              hintText: loc.select,

              hintStyle: TextStyle(
                color: Color(0xFFCACACA),
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            items:
                ExpensesCategory.values
                .where((category) => category != ExpensesCategory.debtClerance) 
                .map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: TextWidget(
                     txt: category.label(context),
                      fontWeight: FontWeight.w500,
                      txtColor: Color(0xFF343434),
                      fontSize: 14.sp,
                    ),
                  );
                }).toList(),
            onChanged: widget.onChanged,
            value: widget.selectedValue,
            validator: (value) {
              if (value == null) {
                return loc.category_required;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
