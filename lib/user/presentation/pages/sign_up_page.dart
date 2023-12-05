import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_app/user/data/model/user.dart';
import 'package:pharmacy_app/user/presentation/bloc/user_data_bloc/user_data_bloc.dart';
import '../../../pharmacy/presentation/pages/controller_page.dart';
import '../bloc/auth_bloc/authentication_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  var email = TextEditingController();
  var name = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> GlobalKeyForm = GlobalKey();
  String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: GlobalKeyForm,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/images/login_signup.json',
                      // Replace with the actual path to your Lottie JSON file
                      width: 250,
                      height: 250,
                      // Other options...
                    ),
                  ),
                  const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 40.0, fontFamily: 'MyFont'),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'field can not be null';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'field can not be null';
                      }
                      if (text.length < 6 ||
                          !text.contains('@') ||
                          !text.endsWith('.com') ||
                          text.startsWith('@')) {
                        return 'Wrong data ';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'field can not be null';
                      }
                      if (text.length < 8) {
                        return 'password must be strong';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Color(0xffa07a52), Color(0xffd6bfa9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        if (GlobalKeyForm.currentState!.validate()) {
                          UserModel userModel =
                          UserModel(name: name.text, id:  '');
                          context.read<AuthenticationBloc>().add(SignUpEvent(
                              email: email.text, password: password.text , userModel));

                         // User? user = await FirebaseAuth.instance.currentUser;


                            context
                                .read<UserDataBloc>()
                                .add(SetUserEvent(userModel: userModel));

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ControllerPage()));
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'MyFont',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
