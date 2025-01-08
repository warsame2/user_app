// import 'package:flutter/material.dart';
// import 'package:user_app/features/dashboard/screens/dashboard_screen.dart';
// import 'package:user_app/features/splash/controllers/splash_controller.dart';
// import 'package:user_app/features/splash/domain/models/config_model.dart';
// import 'package:user_app/localization/language_constrants.dart';
// import 'package:user_app/main.dart';
// import 'package:user_app/utill/custom_themes.dart';
// import 'package:user_app/utill/dimensions.dart';
// import 'package:user_app/utill/images.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MaintenanceScreen extends StatefulWidget {
//   const MaintenanceScreen({super.key});

//   @override
//   State<MaintenanceScreen> createState() => _MaintenanceScreenState();
// }

// class _MaintenanceScreenState extends State<MaintenanceScreen>
//     with WidgetsBindingObserver {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addObserver(this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _checkMaintenanceMode();
//     }
//   }

//   Future<void> _checkMaintenanceMode() async {
//     final splashController =
//         Provider.of<SplashController>(context, listen: false);
//     final isSuccess = await splashController.initConfig(context);
//     if (isSuccess) {
//       final config = splashController.configModel!;

//     }
//   }

//   Widget _buildMaintenanceMessage(ConfigModel configModel) {

//     return Column(
//       children: [
//         Text(
//           "title",
//           style: titilliumBold.copyWith(
//             fontSize: Dimensions.fontSizeLarge,
//             color: Theme.of(context).textTheme.bodyLarge?.color,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//         Text(
//           body,
//           textAlign: TextAlign.justify,
//           style: titilliumRegular,
//         ),
//       ],
//     );
//   }

//   Widget _buildContactOptions(ConfigModel configModel) {


//     return Column(
//       children: [
//         if (maintenanceMessages?.businessNumber == 1)
//           InkWell(
//             onTap: () => launchUrl(
//               Uri.parse('tel:${configModel.companyPhone}'),
//               mode: LaunchMode.externalApplication,
//             ),
//             child: Text(
//               configModel.companyPhone ?? '',
//               style: titleRegular.copyWith(
//                 color: Theme.of(context).indicatorColor,
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ),
//         if (maintenanceMessages?.businessEmail == 1)
//           const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//         if (maintenanceMessages?.businessEmail == 1)
//           InkWell(
//             onTap: () => launchUrl(
//               Uri.parse('mailto:${configModel.companyEmail}'),
//               mode: LaunchMode.externalApplication,
//             ),
//             child: Text(
//               configModel.companyEmail ?? '',
//               style: titleRegular.copyWith(
//                 color: Theme.of(context).indicatorColor,
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final splashController = Provider.of<SplashController>(context);
//     final configModel = splashController.configModel;

//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
//           child: Center(
//             child: configModel == null
//                 ? CircularProgressIndicator()
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(Images.maintenance, width: 200, height: 200),
//                       _buildMaintenanceMessage(configModel),
//                       const SizedBox(height: Dimensions.paddingSizeExtraLarge),
//                       _buildContactOptions(configModel),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
