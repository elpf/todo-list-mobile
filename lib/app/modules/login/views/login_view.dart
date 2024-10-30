import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/data/appcolor.dart';
import 'package:project/app/data/widget_background.dart';
import '../../register/controllers/authentication_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AppColor appColor = AppColor();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: appColor.colorTertiary,
        title: Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          WidgetBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15), // Spacer at the top
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: appColor.colorTertiary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: appColor.colorSecondary),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: appColor.colorSecondary),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: appColor.colorSecondary),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: appColor.colorSecondary),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Obx(() {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor.colorSecondary,
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    ),
                    onPressed: _authController.isLoading.value
                        ? null
                        : () {
                            _authController.loginUser(
                              _emailController.text,
                              _passwordController.text,
                            );
                          },
                    child: _authController.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Login', style: TextStyle(color: Colors.white)),
                  );
                }),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/register'); // Assumes '/register' route is defined for RegisterPage
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: TextStyle(color: appColor.colorSecondary),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15), // Spacer at the bottom
              ],
            ),
          ),
        ],
      ),
    );
  }
}
