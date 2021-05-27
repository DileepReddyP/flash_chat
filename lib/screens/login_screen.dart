import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/input_field.dart';
import 'package:flash_chat/components/option_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              InputField(
                hintText: 'Enter your email',
                onChanged: (value) => email = value.trim(),
                inputController: emailController,
              ),
              SizedBox(
                height: 8.0,
              ),
              InputField(
                hintText: 'Enter your password',
                onChanged: (value) => password = value,
                isPassword: true,
                inputController: passwordController,
              ),
              SizedBox(
                height: 24.0,
              ),
              OptionButton(
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  // print('$email, $password');
                  setState(() {
                    emailController.text = '';
                    passwordController.text = '';
                    showSpinner = true;
                  });
                  try {
                    final thisUser = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (thisUser != null) {
                      email = '';
                      password = '';
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                text: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
