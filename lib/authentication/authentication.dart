import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news/route/app_route.dart';
import 'package:flutter_news/utils/notifications/localNotifications/local_notification.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  static String? _accessToken;
  static String? _idToken;

  static signinGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // AUTHENTICATION
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // CREDENTIALS
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      LocalNotification.showNotification("GOOGLE", "Google Sign in complete");
      return Get.offNamed(AppRoute.home);
    });
  }

  static void signUp(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      LocalNotification.showNotification(
          "SignUp Complete", "you have completly signed up");
      Get.offAllNamed(AppRoute.home);
    }).onError((error, stackTrace) {
      print("sign up error pera $error");
      Get.snackbar("Something wrong while sign up", error.toString());
    });
  }

  static void signin(String email, String password) async {
    final credential;
    credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      LocalNotification.showNotification(
          "SignIn Complete", "you have completly signed in");
      Get.offNamed(AppRoute.home);
    }).onError((error, stackTrace) {
      print("sign in error pera$error");
      Get.snackbar("Something wrong while sign in", error.toString());
    });
  }

  static void signout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut().then((value) {
      print("is logged in or not${isLOggedIn()}");
      LocalNotification.showNotification(
          "Logout Complete", "you are completly logged out");
      return Get.offNamed(AppRoute.signIn);
    }).onError((error, stackTrace) {
      Get.snackbar("Something wrong while sign out", error.toString());
      return null;
    });
  }

  static bool isLOggedIn() {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
}
