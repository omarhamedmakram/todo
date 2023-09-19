import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/modules/login_screan/forget_password/forget_password.dart';
import 'package:todo/modules/register_screen/register_screen.dart';

import '../../core/cash_helper/cash_helper.dart';
import '../../core/net_work/firebase_detuitles/firebase_auth_function.dart';
import '../../core/service/toast.dart';
import '../../core/widget/custem_text_form_field.dart';
import '../../layout/home_layout.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isObscureText = true;

  var fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: Locale("en"),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/SIGN IN.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Login",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: fromKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Welcome back!",
                          style: GoogleFonts.poppins(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        labelText: "E-mail Adress",
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
                      TextFormField(
                          obscureText: isObscureText,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.length < 3) {
                              return "Please Enter your password";
                            }
                            if (!validateStructure(value)) {
                              return 'Enter valid password';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObscureText = !isObscureText;
                                      print(isObscureText);
                                      isObscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility;
                                    });
                                  },
                                  icon: Icon(isObscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                              labelText: "Password",
                              labelStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)))),
                      Container(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ForgetPassword.routeName);
                          },
                          child: Text(
                            "Forget Password",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsetsDirectional.all(12.0),
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            if (fromKey.currentState!.validate()) {
                              FirebaseAuthFunction.loginUser(
                                emailAddress: emailController.text,
                                password: passwordController.text,
                                function: () async {
                                  Timer(
                                    Duration(seconds: 2),
                                    () => Tost.ShowTost(
                                        massage: "تم تسجيل الدخول بنجاح",
                                        toastGravity: ToastGravity.BOTTOM),
                                  );
                                  await CashHelper.SetDate(
                                      key: "login", value: true);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      HomeLayout.routeName, (route) => false);
                                },
                              );
                            }
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsetsDirectional.all(15.0),
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Create Account",
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

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
