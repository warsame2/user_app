import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:user_app/features/auth/controllers/facebook_login_controller.dart';
import 'package:user_app/features/auth/controllers/google_login_controller.dart';
import 'package:user_app/features/banner/controllers/banner_controller.dart';
import 'package:user_app/features/checkout/controllers/checkout_controller.dart';
import 'package:user_app/features/compare/controllers/compare_controller.dart';
import 'package:user_app/features/contact_us/controllers/contact_us_controller.dart';
import 'package:user_app/features/deal/controllers/featured_deal_controller.dart';
import 'package:user_app/features/deal/controllers/flash_deal_controller.dart';
import 'package:user_app/features/location/controllers/location_controller.dart';
import 'package:user_app/features/loyaltyPoint/controllers/loyalty_point_controller.dart';
import 'package:user_app/features/notification/controllers/notification_controller.dart';
import 'package:user_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:user_app/features/order/controllers/order_controller.dart';
import 'package:user_app/features/order_details/controllers/order_details_controller.dart';
import 'package:user_app/features/product/controllers/product_controller.dart';
import 'package:user_app/features/product/controllers/seller_product_controller.dart';
import 'package:user_app/features/product_details/controllers/product_details_controller.dart';
import 'package:user_app/features/profile/controllers/profile_contrroller.dart';
import 'package:user_app/features/refund/controllers/refund_controller.dart';
import 'package:user_app/features/reorder/controllers/re_order_controller.dart';
import 'package:user_app/features/review/controllers/review_controller.dart';
import 'package:user_app/features/shipping/controllers/shipping_controller.dart';
import 'package:user_app/features/splash/controllers/splash_controller.dart';
import 'package:user_app/features/splash/domain/models/screens/splash_screen.dart';
import 'package:user_app/features/support/controllers/support_ticket_controller.dart';
import 'package:user_app/features/wallet/controllers/wallet_controller.dart';
import 'package:user_app/features/wishlist/controllers/wishlist_controller.dart';
import 'package:user_app/localization/controllers/localization_controller.dart';
import 'package:user_app/push_notification/models/notification_body.dart';
import 'package:user_app/features/address/controllers/address_controller.dart';
import 'package:user_app/features/auth/controllers/auth_controller.dart';
import 'package:user_app/features/brand/controllers/brand_controller.dart';
import 'package:user_app/features/cart/controllers/cart_controller.dart';
import 'package:user_app/features/category/controllers/category_controller.dart';
import 'package:user_app/features/chat/controllers/chat_controller.dart';
import 'package:user_app/features/coupon/controllers/coupon_controller.dart';
import 'package:user_app/features/search_product/controllers/search_product_controller.dart';
import 'package:user_app/features/shop/controllers/shop_controller.dart';
import 'package:user_app/theme/controllers/theme_controller.dart';
import 'package:user_app/theme/dark_theme.dart';
import 'package:user_app/theme/light_theme.dart';
import 'package:user_app/utill/app_constants.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;

import 'helper/custom_delegate.dart';
import 'localization/app_localization.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (Firebase.apps.isEmpty) {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "1:456788446251:android:62aa78d367cb5c78482e6e",
              projectId: "com.alfajri.user",
              messagingSenderId:
                  "BAczJ7iUzvo5CeHybOuZBFASTiRE6lDhsKtBW__vvDCackzOZPIBN6MDxNYUQnwUeK8gOsgQQpBok69H5xQv1lU",
              appId: "456788446251")
          // options: DefaultFirebaseOptions.currentPlatform,
          );
    } else {
      await Firebase.initializeApp();
    }
  }
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await di.init();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  NotificationBody? body;
  // try {
  //   final RemoteMessage? remoteMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();
  //   if (remoteMessage != null) {
  //     body = NotificationHelper.convertNotification(remoteMessage.data);
  //   }
  //   await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  //   FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  // } catch (_) {}

  // await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<CategoryController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShopController>()),
      ChangeNotifierProvider(create: (context) => di.sl<FlashDealController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<FeaturedDealController>()),
      ChangeNotifierProvider(create: (context) => di.sl<BrandController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductController>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<ProductDetailsController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<OnBoardingController>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<SearchProductController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatController>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileController>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishListController>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<SupportTicketController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<GoogleSignInController>()),
      // ChangeNotifierProvider(
      //     create: (context) => di.sl<FacebookLoginController>()),
      ChangeNotifierProvider(create: (context) => di.sl<AddressController>()),
      ChangeNotifierProvider(create: (context) => di.sl<WalletController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CompareController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CheckoutController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LoyaltyPointController>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ContactUsController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShippingController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<OrderDetailsController>()),
      ChangeNotifierProvider(create: (context) => di.sl<RefundController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ReOrderController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ReviewController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<SellerProductController>()),
    ],
    child: MyApp(body: body),
  ));
}

class MyApp extends StatelessWidget {
  final NotificationBody? body;
  const MyApp({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    return Consumer<ThemeController>(builder: (context, themeController, _) {
      return MaterialApp(
        title: AppConstants.appName,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: themeController.darkTheme
            ? dark
            : light(
                primaryColor: themeController.selectedPrimaryColor,
                secondaryColor: themeController.selectedPrimaryColor,
              ),
        locale: Provider.of<LocalizationController>(context).locale,
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FallbackLocalizationDelegate()
        ],
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: child!);
        },
        supportedLocales: locals,
        home: SplashScreen()
      );
    });
  }
}

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context)
   {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
