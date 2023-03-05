import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/res/res.dart';
import '../widgets/painter.dart';
import '../widgets/voice_tile.dart';

class VoiceHomeScreen extends StatefulWidget {
  const VoiceHomeScreen({Key? key}) : super(key: key);

  @override
  State<VoiceHomeScreen> createState() => _VoiceHomeScreenState();
}

class _VoiceHomeScreenState extends State<VoiceHomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller
      ..stop()
      ..reset()
      ..repeat(period: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 32.h + MediaQuery.of(context).padding.top),
          Text(
            'Voice',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 32.h),

          SizedBox(height: 24.h),
          Container(
            decoration: BoxDecoration(
              color: SmartyColors.primary
            ),
            child: VoiceTile(
              name: 'Google Assistant',
              onChanged: (bool v) {},
              value: false,
            ),
          ),
          SizedBox(height: 200.h),
          CustomPaint(
            painter: SpritePainter(_controller, SmartyColors.primary),
            child: Icon(Icons.keyboard_voice_rounded,
                color: SmartyColors.tertiary, size: 76.w),
          ),
          const Spacer(),
          Text(
            "Listening${_controller.value > 2 / 3 ? '...' : _controller.value > 1 / 3 ? '..' : '.'}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight:FontWeight.w400,
              fontSize: 20,
            )),

        ],
      ),
    );
  }
}
