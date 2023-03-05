import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smarty/core/navigation/navigator.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? _image;
  final nameController = TextEditingController();
  final ageController=TextEditingController();
  final phoneController= TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Edit Profile',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w400,

        ),)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 75,),
              CircleAvatar(
                radius: 60,
                backgroundImage:
                _image != null ? Image.file(File(_image!.path)).image : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    pickAPhoto();
                  }, child: Icon(Icons.camera_alt_outlined),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: (){
                    takeAPhoto();
                  }, child: Icon(Icons.image)),
                ],
              ),
              SizedBox(height: 20,),

              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Enter your Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller:ageController ,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter your age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter your Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )
                ),
              ),
              SizedBox(height: 20,),
              isLoading
                  ? CircularProgressIndicator()
                  : Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(45)),
                width: MediaQuery.of(context).size.width*0.8,
                    height: 60,
                    child: ElevatedButton(
                onPressed: () {
                    _uploadUserData();
                },
                child: Text('Continue',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
              ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void pickAPhoto() async {
    _image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }
  void takeAPhoto() async {
    _image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> uploadImage() async {
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');

    final uid = FirebaseAuth.instance.currentUser!.uid;

    File file = File(_image!.path);

    await storageRef.putFile(file);

    final url = await storageRef.getDownloadURL();

    FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'profile_picture': url,
      },
      SetOptions(merge: true),
    );
  }

  void _uploadUserData() async {
    setState(() {
      isLoading = true;
    });
    await uploadImage();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'user_name': nameController.text,
        'phone': phoneController.text,
        'age': ageController.text,
      },
      SetOptions(merge: true),
    );

    setState(() {
      isLoading = false;
    });

    AppNavigator.pushNamed(dashboardRoute);
  }
}