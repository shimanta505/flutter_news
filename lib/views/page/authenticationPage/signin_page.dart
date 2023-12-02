import 'package:flutter/material.dart';
import 'package:flutter_news/authentication/authentication.dart';
import 'package:flutter_news/utils/dimensions/dimensions.dart';
import 'package:get/get.dart';
import 'package:flutter_news/route/app_route.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(Dimensions.height20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _header(context),
            SizedBox(
              height: Dimensions.height40,
            ),
            _inputField(context),
            _forgotPassword(context),
            _signup(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(
              fontSize: Dimensions.font40, fontWeight: FontWeight.bold),
        ),
        const Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radious20),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        SizedBox(height: Dimensions.height10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radious20),
                borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        SizedBox(height: Dimensions.height40),
        ElevatedButton(
          onPressed: () {
            AuthService.signin(_emailController.text.toString(),
                _passwordController.text.toString());
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: Dimensions.height20),
            backgroundColor: Colors.purple,
          ),
          child: Text(
            "Login",
            style: TextStyle(fontSize: Dimensions.font20),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () async {
              return Get.offNamed(AppRoute.signUp);
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
/* 
waht i can do now if all my requirement is lets make software now 
this is the perfect time for this dev
we should make our self more reliable now or then 
nothing can change us from others our

*/
