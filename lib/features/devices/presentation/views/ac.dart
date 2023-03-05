import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../../utils/enums.dart';

import '../../../../core/navigation/navigator.dart';
import '../../../../shared/res/res.dart';
import '../../../../shared/widgets/power_btn.dart';
import '../../domain/models/devices.dart';

class AcScreen extends StatefulWidget {
  final Device device;
  AcScreen({Key? key, required this.device})
      : assert(device.type == DeviceType.ac),
        super(key: key);

  @override
  State<AcScreen> createState() => _AcScreenState();
}

class _AcScreenState extends State<AcScreen> {
  double temp = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h + MediaQuery.of(context).padding.top),
              Row(
                children: [
                  if (AppNavigator.canPop)
                    GestureDetector(
                      onTap: () => AppNavigator.pop(),
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Fan',
                        style: TextStyles.headline4,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fan',
                        style: TextStyles.headline4
                            .copyWith(color: SmartyColors.grey),
                      ),
                      Text(
                        widget.device.room,
                        style: TextStyles.body
                            .copyWith(color: SmartyColors.grey60),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Temperature',
                        style: TextStyles.body
                            .copyWith(color: SmartyColors.grey60),
                      ),
                      Text(
                        '25°C',
                        style: TextStyles.body
                            .copyWith(color: SmartyColors.grey60),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 5,
                  initialValue: temp,
                  appearance: CircularSliderAppearance(
                    size: 300.r,
                    customColors: CustomSliderColors(
                      progressBarColor: SmartyColors.primary,
                      trackColor: SmartyColors.grey30,
                      dotColor: SmartyColors.primary,
                    ),
                    customWidths: CustomSliderWidths(
                      progressBarWidth: 8.w,
                      trackWidth: 8.w,
                      handlerSize: 16.r,
                    ),
                  ),
                  onChange: (double value) {
                    setState(() {
                      temp = double.parse(value.toStringAsFixed(1));
                    });
                  },
                  onChangeStart: (double startValue) {
                    // callback providing a starting value (when a pan gesture starts)
                  },
                  onChangeEnd: (double endValue) {
                    // callback providing an ending value (when a pan gesture ends)
                  },
                  innerWidget: (double value) {
                    //This the widget that will show current value
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "cool",
                            style: TextStyles.body
                                .copyWith(color: SmartyColors.grey60),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: temp.floor() <= 0
                                    ? SmartyColors.grey30
                                    : SmartyColors.primary,
                                child: IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: temp.floor() <= 0
                                      ? null
                                      : () {
                                          setState(() {
                                            temp--;
                                          });
                                        },
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                "${value.toStringAsFixed(1)}",
                                style: TextStyles.headline4.copyWith(
                                  color: SmartyColors.grey80,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              CircleAvatar(
                                backgroundColor: temp.round() == 31
                                    ? SmartyColors.grey30
                                    : SmartyColors.primary,
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: temp.round() == 31
                                      ? null
                                      : () {
                                          setState(() {
                                            temp++;
                                          });
                                        },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 56.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 27.5.w, vertical: 6.5.h),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 62.w),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 48.w, vertical: 10.h),
                    ),
                    SizedBox(height: 56.h),
                  ],
                ),
              ),
              SizedBox(height: 80.h),
              const ChipButton(
                child: Icon(Icons.power_settings_new_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
