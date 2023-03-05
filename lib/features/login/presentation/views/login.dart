import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:smarty/core/navigation/navigator.dart';


import '../../../../base.dart';
import '../../../../register/register_screen.dart';
import '../../../../register/validation_utils.dart';
import '../../../../shared/res/colors.dart';
import '../../../../shared/res/typography.dart';
import 'forgetPasword.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen,LoginViewModel>
    implements LoginNavigator {
  bool securedPassword = true;


  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>viewModel,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 159.h),
                    Image.asset("assets/images/logo.png",
                        color: SmartyColors.primary, width: 174.w),
                    SizedBox(height: 25.h),
                    Text(
                      'Login to your account',
                      style: TextStyles.headline4.copyWith(
                          color: SmartyColors.primary, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 25.h),
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
                    SizedBox(height: 25.h),

                    TextFormField(
                      obscureText: securedPassword,
                      controller: passwordController,
                      validator:(text){
                        if (text == null || text.trim().isEmpty){
                          return 'please enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: InkWell(
                          onTap: (){
                            securedPassword =!securedPassword;setState(() {
                            });
                          },
                          child: Icon(
                            securedPassword ?
                            Icons.visibility : Icons.visibility_off,

                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    MaterialButton(onPressed: (){
                      signIN();
                    },
                      minWidth: double.infinity,
                      child: Text('Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      color: Color(0xff3700b3),
                      height: 50,

                    ),
                    SizedBox(height: 25.h),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont have an account?'),
                          TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Regester()));
                          },
                              child: Text('Sign Up',
                                style: TextStyle(
                                  color: Color(0xff3700b3),
                                  fontSize: 16.0,
                                ),
                              ),

                          )
                        ],

                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgetScreen()));
                          }, child: Text('Forget Password?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ),
                          )),
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
  void signIN(){
    if(formKey.currentState?.validate()== false){
      return;
    }
    viewModel.login(emailController.text, passwordController.text);
  }
  @override
  void gotoHome() {
AppNavigator.pushNamed(dashboardRoute);
  }

}
