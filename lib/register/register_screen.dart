
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smarty/features/home/presentation/views/home.dart';
import 'package:smarty/features/login/presentation/phone_auth/login.dart';
import 'package:smarty/features/login/presentation/views/login.dart';
import 'package:smarty/register/register_view_model.dart';
import 'package:smarty/register/validation_utils.dart';

import '../base.dart';
import '../shared/res/colors.dart';
import '../shared/res/typography.dart';


class Regester extends StatefulWidget {
  static const String routeName = 'register';
  @override
  State<Regester> createState() => _RegesterState();
}


class _RegesterState extends BaseState<Regester,RegisterViewModel>
implements RegisterNavigator {
  bool securePassword = true;

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }
  @override
  LoginPhoneScreen LoginScreenPhone() {
       return LoginPhoneScreen();  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>viewModel,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Image.asset("assets/images/logo.png",
                        color: SmartyColors.primary, width: 174.w),
                    SizedBox(height: 55.h),
                    Text(
                      'Create an account',
                      style: TextStyles.headline4.copyWith(
                          color: SmartyColors.primary, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 30.h),
                    TextFormField(
                      controller: userNameController,
                      validator:(text){
                        if (text == null || text.trim().isEmpty){
                          return 'please enter User Name';
                        }
                        if (text.length < 3) {
                          return 'User Name must be more than 2 char';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'User Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: emailController,
                      validator:(text){
                        if (text == null || text.trim().isEmpty){
                          return 'please enter Email';
                        }
                        if(!ValidationUtils.isValidEmail(text)){
                          return 'please enter a valid Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),

                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      obscureText: securePassword,
                      controller: passwordController,
                      validator:(text){
                        if (text == null || text.trim().isEmpty){
                          return 'please enter Password';
                        }
                        if (text.length <8) {
                          return 'Password should be at least 8 chars';
                        }
                        return null;
                      },
                      decoration: InputDecoration(

                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: InkWell(
                          onTap: (){
                            securePassword =!securePassword;
                            setState(() {

                            });
                          },
                          child: Icon(
                            securePassword ?
                            Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),

                    ),
                    SizedBox(height: 20.0,),
                    MaterialButton(onPressed: (){
                      createAccountClicked();
                    },

                      child: Text('Sign up',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                      ),
                       color: Color(0xff3700b3),
                      height: 50,
                      minWidth: double.infinity,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Do have an account?'),
                          TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                              child: Text('Sign IN',
                                style: TextStyle(
                                  color: Color(0xff3700b3),
                                  fontSize: 16.0,
                                ),
                              )

                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  var authService = FirebaseAuth.instance;
  void createAccountClicked(){
    if(formKey.currentState?.validate()== false){
      return;
    }
    viewModel.register(emailController.text, passwordController.text,userNameController.text);
  }

  @override
  void gotoHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPhoneScreen()));
  }



}