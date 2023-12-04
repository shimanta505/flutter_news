import 'package:flutter/material.dart';
import 'package:flutter_news/authentication/authentication.dart';
import 'package:flutter_news/route/app_route.dart';
import 'package:get/get.dart';

import '../../../utils/dimensions/dimensions.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width40),
          height: MediaQuery.of(context).size.height - Dimensions.height50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: Dimensions.height60),
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: Dimensions.font30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Text(
                    "Create your account",
                    style: TextStyle(
                        fontSize: Dimensions.font16, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radious20),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.person)),
                  ),
                  SizedBox(height: Dimensions.height20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radious20),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.email)),
                  ),
                  SizedBox(height: Dimensions.height20),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radious20),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: Dimensions.height20),
                  TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radious20),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height5, left: Dimensions.width5),
                  child: ElevatedButton(
                    onPressed: () {
                      AuthService.signUp(emailController.text.toString(),
                          passwordController.text.toString());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding:
                          EdgeInsets.symmetric(vertical: Dimensions.height15),
                      backgroundColor: Colors.purple,
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(fontSize: Dimensions.font20),
                    ),
                  )),
              const Center(child: Text("Or")),
              Container(
                height: Dimensions.height40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radious20),
                  border: Border.all(
                    color: Colors.purple,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    return AuthService.signinGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: Dimensions.height40,
                        width: Dimensions.width40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/login_signup/google.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: Dimensions.width20),
                      Text(
                        "Sign In with Google",
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoute.signIn);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.purple),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
