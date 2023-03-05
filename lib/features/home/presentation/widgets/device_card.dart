import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/navigation/navigator.dart';
import '../../../../shared/res/res.dart';
import '../../../devices/domain/models/devices.dart';
import '../../../../utils/enums.dart';

class DeviceCard extends StatefulWidget {
  final Device device;
  const DeviceCard({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.pushNamed(widget.device.type.routeName,
          arguments: widget.device),
      child: Container(
        padding: EdgeInsets.all(16.r),
        margin: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
          color: SmartyColors.primary80,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  widget.device.type.icon ?? 'assets/icons/fan.png',
                  width: 48.w,
                ),
                SizedBox(width: 32.w),
                Switch.adaptive(
                  activeColor: SmartyColors.tertiary,
                  value: widget.device.active,
                  onChanged: (bool v) {
                    setState(() {
                      widget.device.active = v;
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Text(
              widget.device.name ?? widget.device.type.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: SmartyColors.tertiary,),
            ),
            SizedBox(height: 4.h),
            Text(
              widget.device.room,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: SmartyColors.tertiary,),
            )
          ],
        ),
      ),
    );
  }
}
