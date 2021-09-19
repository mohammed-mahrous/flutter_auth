import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanctum_auth_app/services/auth.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _thisformkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late bool _passwordObsecured;
  String serverUrl = 'select server';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordObsecured = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Auth auth, child) {
      return Form(
        key: _thisformkey,
        child: Container(
          color: Colors.deepPurpleAccent,
          padding: EdgeInsets.all(15),
          width: 300,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: TextFormField(
                  controller: usernameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Enter your username/email here',
                    filled: true,
                    fillColor: Color(0xFFFFFFFFF),
                    border: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: TextFormField(
                  obscureText: _passwordObsecured,
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(_passwordObsecured
                          ? Icons.visibility_off_rounded
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _passwordObsecured = !_passwordObsecured;
                        });
                      },
                    ),
                    hintText: 'Enter your password here',
                    filled: true,
                    fillColor: Color(0xFFFFFFFFF),
                    border: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  child: Text(auth.processing ? 'loading...' : 'submit'),
                  onPressed: !auth.processing
                      ? () {
                          if (_thisformkey.currentState!.validate()) {
                            Map creds = {
                              'username': usernameController.text,
                              'password': passwordController.text,
                              'device_name': 'linux',
                            };
                            Provider.of<Auth>(context, listen: false).login(
                                context: context, message: '', creds: creds);

                            Navigator.of(context).pushReplacementNamed('/home');
                          }
                        }
                      : null,
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  DropdownButton<String> mydropdownbutton() {
    return DropdownButton(
      dropdownColor: Colors.white,
      value: serverUrl,
      icon: const Icon(
        Icons.arrow_downward,
        color: Colors.black,
      ),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(
        color: Colors.black,
      ),
      underline: Container(
        height: 2,
      ),
      onChanged: (String? newValue) {
        setState(() {
          serverUrl = newValue!;
        });
      },
      items: [
        'select server',
        'server_One',
        'server_Two',
        'server_three',
        'server_Four'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
