import 'package:flutter/material.dart';
import 'package:login_firebaseapp/registration.dart';
import 'package:login_firebaseapp/services/authenticatio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MaterialApp(home: LoginScreen()),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();

  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        color: Colors.deepPurpleAccent,
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'Login',
                  style: TextStyle(
                      color: Color.fromARGB(255, 15, 14, 14),
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                ),

                Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _emailContoller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 20, 19, 19),
                              )),
                          style:
                              TextStyle(color: Color.fromARGB(255, 15, 14, 14)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            } else
                              return null;
                          },
                          obscureText: true,
                          style:
                              TextStyle(color: Color.fromARGB(255, 15, 14, 14)),
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 48, 47, 47))),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 12, 12, 12).withAlpha(55)),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegistrationScreen()));
                          },
                          child: Text(
                            'Not Registered? Signup',
                            style: TextStyle(
                                color: Color.fromARGB(255, 15, 14, 14)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 14, 14, 14)
                                        .withAlpha(55)),
                              ),
                              onPressed: (){
                                if(_key.currentState!.validate())
                                {

                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 11, 11, 11),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// void signInUser() async{
//   dynamic authResult = await _auth.loginUser
//   if (authResult == null) {
//       print('Sign in error. could not be able to login');
//     }
// }