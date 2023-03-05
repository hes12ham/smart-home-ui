import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/res/res.dart';

class QuickAction extends StatelessWidget {
  final String action;
  const QuickAction({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: SmartyColors.primary,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sunny, size: 24.w, color: SmartyColors.tertiary),
              SizedBox(width: 4.w),
              Text(
                action,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: SmartyColors.tertiary,
              )
              ),],
          ),
          SizedBox(height: 4.h),
          Text(
            '6:00 AM',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: SmartyColors.tertiary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '5 Devices',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: SmartyColors.tertiary,
          )
              ),  ],
      ),
    );
  }
}
