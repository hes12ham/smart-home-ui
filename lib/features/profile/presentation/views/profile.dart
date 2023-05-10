
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarty/features/login/presentation/views/login.dart';
import 'package:smarty/features/profile/presentation/views/photoScreen.dart';

import '../../../../appCubit/app_cubit.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../shared/res/res.dart';
import '../widgets/general_tile.dart';
import '../widgets/member_tile.dart';
import '../widgets/settings_tile.dart';
import '../widgets/summary_tile.dart';

class ProfileScreen extends StatelessWidget {
  final Widget trailing;
  const ProfileScreen({Key? key, required this.trailing}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final usersCollection = FirebaseFirestore.instance.collection('users');
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot>(

        future: usersCollection.doc(userId).get(),
        builder: (context, snapshot) {

          if(snapshot.hasError) {
            return SizedBox(child: Text('There is an error'));
          }

          if(snapshot.hasData) {
            final data = snapshot.data!.data() as Map<String, dynamic>;


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
                              child: const Icon(Icons.arrow_back_ios,color: Color(0xff3700b3)),
                            ),
                          const Expanded(
                            child: Center(
                              child: SizedBox.shrink(),
                            ),
                          ),
                          trailing
                        ],
                      ),
                      SizedBox(height: 18.h),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.r,
                              backgroundImage:
                              NetworkImage("${data['profile_picture']??""}"),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                             ("${data['email']??""}"),
                              style:TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                                ("${data['userName']??""}"),
                              style:TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 48.h),
                      SizedBox(height: 48.h),
                      Text(
                        'General Settings',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                       height: 60,
                        decoration: BoxDecoration(
                          color: SmartyColors.primary,
                        ),
                        child: ElevatedButton(
                          onPressed: () => AppNavigator.pushNamed(settingsRoute),
                          child: Row(
                            children: [
                              Icon(Icons.settings),
                              SizedBox(width: 95,),
                              Text("Setting",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),),
                              SizedBox(width: 95,),
                              Icon(Icons.arrow_forward_ios_outlined),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 52.h),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: SmartyColors.primary,
                        ),
                        child: ElevatedButton(
                          onPressed: () => AppNavigator.pushNamed(settingsRoute),
                          child: Row(
                            children: [

                              Text("Dark Mode",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),),
                              SizedBox(width: 160,),
                              IconButton(onPressed: () {
                                AppCubit.get(context).changeAppMode();
                              }, icon: Icon(Icons.brightness_4_outlined),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 52.h),

                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: SignInButtonBuilder(

                          icon: Icons.logout_outlined,
                          text: "Log Out",
                          textColor: Colors.white,
                          fontSize: 25,
                          onPressed: () async {

                            AppNavigator.pushNamedAndClear(loginRoute);
                          }, backgroundColor: Color(0xff3700b3),
                        ),
                      ),

                    ],

                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }
  }

