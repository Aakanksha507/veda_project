import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/widget/list_container_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:myflutterapp/l10n/app_localizations.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final List<Map<String, dynamic>> mssgList = [
      {
        'main': loc.bankOfAmerica,
        'secondarytxt': loc.bankOfAmericaSecondaryText,
        'date': loc.date_today,
        'icon': 'assets/icon/33.svg',
        'bgColor': AppColor.primary1,
      },
      {
        'main': loc.account,
        'secondarytxt': loc.accountSecondaryText,
        'date': loc.date_12_10,
        'icon': 'assets/icon/09.svg',
        'bgColor': AppColor.semantic1,
      },
      {
        'main': loc.alert,
        'secondarytxt': loc.alertSecondaryText,
        'date': loc.date_11_10,
        'icon': 'assets/icon/Group.svg',
        'bgColor': AppColor.semantic2,
      },
      {
        'main': loc.paypal,
        'secondarytxt': loc.paypalSecondaryText,
        'date': loc.date_10_11,
        'icon': 'assets/icon/11.svg',
        'bgColor': AppColor.semantic3,
      },
      {
        'main': loc.withdraw,
        'secondarytxt': loc.withdrawSecondaryText,
        'date': loc.date_10_12,
        'icon': 'assets/icon/credit-card.svg',
        'bgColor': AppColor.semantic4,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.neutral6,
        title: AppBarWidget(
          mainTxt: loc.message,
          bgColor: AppColor.neutral6,
          txtColor: AppColor.neutral1,
          iconColor: AppColor.neutral1,
        ),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: mssgList.length,
        separatorBuilder: (context, index) => const SizedBox(),
        itemBuilder: (context, index) {
          final mssg = mssgList[index];
          return ListContainerWidget(
            title: mssg['main'],
            description: mssg['secondarytxt'],
            txtTapping: mssg['date'],
            iconBgColor: mssg['bgColor'],
            leadingIconPath: mssg['icon'],
            radius: 15.r,
            ontap: (){
              showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    surfaceTintColor: AppColor.neutral6,
                    icon: SvgPicture.asset(
                      mssg['icon'],
                      color: mssg['bgColor'],
                      width: 20,
                      height: 20, 
                    ),
                    
                    title: Text(mssg['main'] ?? 'No Title'),
                    content: Text(mssg['secondarytxt'] ?? 'No Content'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
            );
          
            },
          );
        },
      ),
    );
  }
}
