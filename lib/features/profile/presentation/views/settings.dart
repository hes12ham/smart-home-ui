import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarty/appCubit/app_cubit.dart';
import 'package:smarty/features/voice/presentation/widgets/voice_tile.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../shared/res/res.dart';
import '../widgets/settings_tile.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                        child: const Icon(Icons.arrow_back_ios,),
                      ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Settings',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 22
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: SmartyColors.grey,
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: SettingsTile(
                    title: 'Dark Mode',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 8.w),
                        IconButton(onPressed: (){
                          AppCubit.get(context).changeAppMode();
                          }, icon: Icon(Icons.brightness_4_outlined)),

                      ],

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
}
