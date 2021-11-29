import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:interactivemap/Model/UserRepository.dart';
import 'MainPage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  @override
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  User user = new User();

  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/LoginBackground.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.5, sigmaY: 5.5),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width / 1.3,
                color: Colors.white38.withOpacity(0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(23, 15, 23, 0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: HexColor("#464A4A").withOpacity(0.4),
                            filled: true),
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(23, 15, 23, 0),
                      child: TextField(
                        controller: passController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: HexColor("#464A4A").withOpacity(0.4),
                            filled: true),
                        style: TextStyle(color: Colors.white70),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey.shade600.withOpacity(0.6),
                            elevation: 0.5,
                          ),
                          onPressed: () async {
                            EasyLoading.show(status: 'loading...');
                            bool authorized = await user.Login(
                                emailController.text.trim(),
                                passController.text.trim());
                            if (authorized == true) {
                              EasyLoading.showSuccess('Logging In!!');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserPage()));
                            } else {
                              EasyLoading.showError('Invalid Credentials');
                            }

                          },
                          child: Text("Log In")),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                                .withOpacity(0.6), // red as border color
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Ink(
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      child: Image.asset(
                                          'assets/images/google_logo.png'),
                                      height: 15,
                                      width: 15,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Sign in with Google',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Not a user? Register here",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
