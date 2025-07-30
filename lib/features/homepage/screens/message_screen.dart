import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/widget/list_container_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  final List<Map<String, dynamic>> mssgList = const [
    {
      'main': 'Bank of America',
      'secondarytxt': 'Bank of America : 256486 is the au..',
      'date': 'Today',
      'icon': 'assets/icon/33.svg',
      'bgColor': AppColor.primary1,
    },
    {
      'main': 'Account',
      'secondarytxt': 'Your account is limited. Please foll..',
      'date': '12/10',
      'icon': 'assets/icon/09.svg',
      'bgColor': AppColor.semantic1,
    },
    {
      'main': 'Alert',
      'secondarytxt': 'Your statement is ready for you to..',
      'date': '11/10',
      'icon': 'assets/icon/Group.svg',
      'bgColor': AppColor.semantic2,
    },
    {
      'main': 'PayPal',
      'secondarytxt': 'Your account has been locked..',
      'date': '10/11',
      'icon': 'assets/icon/11.svg',
      'bgColor': AppColor.semantic3,
    },
    {
      'main': 'Withdraw',
      'secondarytxt': 'Dear customer, 2987456 is your co...',
      'date': '10/12',
      'icon': 'assets/icon/credit-card.svg',
      'bgColor': AppColor.semantic4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:  AppColor.neutral6,
        title: AppBarWidget(mainTxt: 'Message',
         bgColor: AppColor.neutral6,
          txtColor: AppColor.neutral1, 
           iconColor:AppColor.neutral1),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: mssgList.length,
        separatorBuilder: (context, index) => const SizedBox(),
        itemBuilder: (context, index) {
          final mssg = mssgList[index];
          return  ListContainerWidget(title: mssg['main'], 
              description: mssg['secondarytxt'], 
              txtTapping: mssg['date'],
               iconBgColor: mssg['bgColor'],
                leadingIconPath: mssg['icon'],
                radius: 15.r,
                 );
          
        },
      ),
    );
  }
}
