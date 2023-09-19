import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/core/net_work/firebase_detuitles/database/user_database.dart';
import 'package:todo/model/user_model.dart';

import '../../service/toast.dart';

class FirebaseAuthFunction {
  static Future<void> SignUpUser(
      {required String emailAddress,
      required String password,
      required Function function,
      required String name}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      )
          .then((value) {
        UserModel userModel =
            UserModel(name: name, email: emailAddress, id: value.user!.uid);
        UserDatabase.addUser(userModel, value.user!.uid);
        (
          massage: "You have been logged in successfully",
          toastGravity: ToastGravity.BOTTOM,
        );
        function();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Tost.ShowTost(
          massage: "The password provided is too weak",
          toastGravity: ToastGravity.BOTTOM,
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Tost.ShowTost(
          massage: "The account already exists for that email",
          toastGravity: ToastGravity.BOTTOM,
        );

        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> loginUser({
    required String emailAddress,
    required String password,
    required Function function,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) {
        Tost.ShowTost(
          massage: "You have been logged in successfully",
          toastGravity: ToastGravity.BOTTOM,
        );
        function();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Tost.ShowTost(
          massage: "No user found for that email",
          toastGravity: ToastGravity.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        Tost.ShowTost(
          massage: "No user found for that email",
          toastGravity: ToastGravity.BOTTOM,
        );
        print('No user found for that email.');
      }
    }
  }

  static Future<void> forgetPassword({required String email}) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> SignOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
