// import 'package:flutter/foundation.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// // class FacebookLoginController with ChangeNotifier {
// //   Map? userData;
// //   late LoginResult result;

// //   Future<void> login() async {
// //     result = await FacebookAuth.instance.login();
// //     if (result.status == LoginStatus.success) {
// //       userData = await FacebookAuth.instance.getUserData();

// //     }
// //     notifyListeners();
// //   }

// // }

// class FacebookLoginController with ChangeNotifier {
//   Map<String, dynamic>? userData;
//   late LoginResult result;
//   late AccessToken? accessToken;
//   Future<void> login() async {
//     // تسجيل الدخول
//     result = await FacebookAuth.instance.login();
//     if (result.status == LoginStatus.success) {
//       // استرداد بيانات المستخدم
//       userData = await FacebookAuth.instance.getUserData(fields: "id,name,email");
//       notifyListeners();
//     } else {
//       print("Login failed: ${result.status}");
//     }
//   }

//   String? get userId => userData?['id'];
//     String? get token => accessToken?.tokenString;
// }
