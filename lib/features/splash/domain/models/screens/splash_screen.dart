import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user_app/common/basewidget/bouncy_widget.dart';
import 'package:user_app/features/splash/controllers/splash_controller.dart';
import 'package:user_app/push_notification/models/notification_body.dart';
import 'package:user_app/utill/app_constants.dart';

import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/utill/images.dart';
import 'package:user_app/common/basewidget/no_internet_screen_widget.dart';

import 'package:provider/provider.dart';

import '../../../../../main.dart';
import '../../../../auth/controllers/auth_controller.dart';
import '../../../../dashboard/screens/dashboard_screen.dart';
import '../../../../home/screens/home_screens.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({super.key, this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() => _route());
  }

  void _route() {
    final splashController =
        Provider.of<SplashController>(context, listen: false);
    splashController.initConfig(context).then((bool isSuccess) {
      if (isSuccess) {
        splashController.initSharedPrefData();
        _timer = Timer(const Duration(seconds: 2), () {
          _navigateToHomePage();
        });
      }
    });
  }

  void _navigateToHomePage() {
    String token =
        Provider.of<AuthController>(Get.context!, listen: false).getUserToken();
    if (token.isNotEmpty) {
    print("_________________token______${token}_____________________");

                                  Navigator.pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      const DashBoardScreen()),
                                                              (route) => false);
  
    }else{

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
    }

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _globalKey,
      body: Consumer<SplashController>(
        builder: (context, splashController, child) {
          return splashController.hasConnection
              ? _buildSplashContent(context)
              : const NoInternetOrDataScreenWidget(
                  isNoInternet: true, child: SplashScreen());
        },
      ),
    );
  }

  Widget _buildSplashContent(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        BouncyWidget(
          duration: const Duration(milliseconds: 2000),
          lift: 50,
          ratio: 0.5,
          pause: 0.25,
          child: SizedBox(
            width: 150,
            child: Image.asset(Images.icon, width: 150.0),
          ),
        ),
        Text(AppConstants.appName,
            style: textRegular.copyWith(
                fontSize: Dimensions.fontSizeOverLarge, color: Colors.white)),
        Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          child: Text(AppConstants.slogan,
              style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault, color: Colors.white)),
        )
      ]),
    );
  }
}
