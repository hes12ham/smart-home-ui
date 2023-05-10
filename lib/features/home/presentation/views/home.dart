import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import '../../../../core/navigation/navigator.dart';

import '../../../devices/domain/models/devices.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget
{

  const HomeScreen({Key? key}) : super(key: key);
  @override


  @override
  Widget build(BuildContext context) {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final userId = FirebaseAuth.instance.currentUser!.uid;


    return FutureBuilder<DocumentSnapshot>(
        future: usersCollection.doc(userId).get(),
        builder: (context, snapshot) {

          if(snapshot.hasError) {
          }

          if(snapshot.hasData) {
            final data = snapshot.data?.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: 32.h + MediaQuery.of(context).padding.top),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Hello, ${data['userName']??""}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => AppNavigator.pushNamed(
                          profileRoute,
                        ),
                        child:  CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(data['profile_picture']??"${Icon(Icons.person)}"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  const SummaryHeader(),
                  SizedBox(height: 32.h),
                  SizedBox(height: 16.h),
                  Text(
                    'Active Devices',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 16.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [...devices.map((e) => DeviceCard(device: e))],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [...devices.map((e) => DeviceCard(device: e))],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [...devices.map((e) => DeviceCard(device: e))],
                    ),
                  ),
                ]),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());


        }
    );
  }
  }

