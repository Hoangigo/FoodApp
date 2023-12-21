import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mealsapp/controller/auth_controller.dart';
import 'package:mealsapp/widgets/image_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUserName = '';
  File? _selectedImage;
  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || !_isLogin && _selectedImage == null) return;
    _form.currentState!.save();
    AuthController().submitUserCredentials(_enteredEmail, _enteredPassword,
        _enteredUserName, _selectedImage, _isLogin, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 63, 17, 177),
      appBar: AppBar(actions: []),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              width: 200,
              child: Image.asset('assets/images/chat.png'),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(pickImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            }),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Email address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter valid Email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: 'Username',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().length < 4) {
                                  return 'password muss at least 4 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredUserName = value!;
                              },
                            ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 8) {
                                return 'password muss at least 8 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            onPressed: _submit,
                            child: Text(_isLogin ? 'Login' : 'Sign up'),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'I already have an account'))
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
