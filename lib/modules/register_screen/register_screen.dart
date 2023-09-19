import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/net_work/firebase_detuitles/firebase_auth_function.dart';
import 'package:todo/layout/home_layout.dart';

import '../../core/cash_helper/cash_helper.dart';
import '../../core/service/toast.dart';
import '../../core/widget/custem_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController(text: "Kb246819!");

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
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Create Account",
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
                      CustomTextFormField(
                        controller: nameController,
                        labelText: "Name",
                        textInputType: TextInputType.name,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.length < 3) {
                            return "Please Enter your Name";
                          }
                          return null;
                        },
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
                      SizedBox(height: 60),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsetsDirectional.all(10.0),
                              backgroundColor: Colors.white),
                          onPressed: () {
                            if (fromKey.currentState!.validate()) {
                              FirebaseAuthFunction.SignUpUser(
                                emailAddress: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
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
                              Text(
                                "Create Account",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                                size: 30,
                              )
                            ],
                          ))
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
