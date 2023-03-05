import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarty/register/shared_data.dart';

import '../base.dart';
import 'MyDataBase.dart';
import 'my_user.dart';

abstract class RegisterNavigator extends BaseNavigator{
  void gotoHome();
  void LoginScreenPhone();
}
class RegisterViewModel extends BaseViewModel<RegisterNavigator>{

  var auth = FirebaseAuth.instance;

  void register(
      String email ,
      String password,
      String userName,
      )async{
    navigator?.showLoadingDialog();
    try {
      var credential= await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      MyUser newUser=MyUser(
        id: credential.user?.uid,
        userName: userName,
        email: email,
      );

      //auth.currentUser?.updateProfile(displayName: userName);
      //credential.user?.updateProfile(displayName: userName);
      credential.user!.updateDisplayName('userName');

      var insertedUser = await MyDataBase.insertUser(newUser);
      if(insertedUser != null){
        // user inserted successfully
        SharedData.user = insertedUser;
        navigator?.LoginScreenPhone();
      }else {
        // error with database, show error
        navigator?.showMessageDialog('something went wrong, error with data base');
      }
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(credential.user?.uid ??'');
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      if (e.code == 'weak-password') {
        navigator?.showMessageDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessageDialog('Email is already registered');
      }
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('something went wrong ,please try again later');

    }
  }
}