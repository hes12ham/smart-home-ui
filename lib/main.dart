import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smarty/appCubit/app_cubit.dart';
import 'package:smarty/features/home/presentation/views/home.dart';
import 'package:smarty/features/login/presentation/phone_auth/login.dart';
import 'package:smarty/features/login/presentation/views/login.dart';
import 'package:smarty/features/profile/presentation/views/photoScreen.dart';
import 'package:smarty/register/register_screen.dart';
import 'core/navigation/navigator.dart';
import 'shared/res/res.dart';
import 'shared/widgets/onboarding_widget.dart';
import 'shared/widgets/page_indicator.dart';
import 'shared/widgets/widgets.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AppCubit(),
          child: BlocConsumer<AppCubit, AppState>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Smarty',
                theme: MyThemes.lightThememode,
                darkTheme: MyThemes.darkThememode,
                themeMode:AppCubit.get(context).isDark ?ThemeMode.dark:ThemeMode.light,
                home: StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return   MyHomePage();
                      }
                      else {
                        return LoginScreen();
                      }
                    }
                ),
                onGenerateRoute: AppRouter.generateRoutes,
                navigatorKey: AppNavigator.key,
              );
            },
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController? _pageController;
  Timer? _pageAnimationTimer;
  int _page = 0;

  void _animatePages() {
    if (_pageController == null) return;
    if (_page < 2) {
      _pageController?.nextPage(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageAnimationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _animatePages();
    });
  }

  @override
  void dispose() {
    _pageAnimationTimer?.cancel();
    _pageAnimationTimer = null;
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: PageView(
                controller: _pageController,
                onPageChanged: (newPage) {
                  setState(() {
                    _page = newPage;
                  });
                },
                children: const [
                  OnboardingWidget(
                    image: 'assets/images/home1.png',
                    title: 'Smart',
                    subtitle:
                    'Manage the power usage of all your electronic device at your convinience',
                  ),
                  OnboardingWidget(
                    image: 'assets/images/home2.png',
                    title: 'Control',
                    subtitle:
                    'Control all your electronic devices with at a single click with just your smart phone',
                  ),
                  OnboardingWidget(
                    image: 'assets/images/home3.png',
                    title: 'Autoomate',
                    subtitle:
                    'Create routines and schedule devices to run along with your routine',
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    SizedBox(height: 64.h),
                    PageIndicatorWidget(
                      count: 3,
                      value: _page,
                      size: 12.w,
                    ),
                    SizedBox(height: 64.h),
                    AppButtonPrimary(
                      label: 'Get Started',
                      onPressed: () async =>
                       await   AppNavigator.pushNamedReplacement(dashboardRoute),
                    ),
                    // SizedBox(height: 42.h),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
