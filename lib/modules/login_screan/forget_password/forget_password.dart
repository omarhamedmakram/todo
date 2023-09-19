import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/net_work/firebase_detuitles/firebase_auth_function.dart';
import 'package:todo/modules/login_screan/login_screan.dart';

import '../../../core/widget/custem_text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = "ForgetPassword";

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var emailController = TextEditingController();
  var fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/SIGN IN.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Forget Password",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        ),
        body: Localizations.override(
          context: context,
          locale: Locale("en"),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: fromKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: emailController,
                        labelText: "E-mail Address",
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter your Email";
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]"
                                  r"+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return 'Enter valid password';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsetsDirectional.all(15.0),
                              backgroundColor: Colors.white),
                          onPressed: () {
                            if (fromKey.currentState!.validate()) {
                              FirebaseAuthFunction.forgetPassword(
                                      email: emailController.text)
                                  .then((value) {
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "go to Screen  Login ",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
