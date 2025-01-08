import 'dart:async';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../common/basewidget/custom_asset_image_widget.dart';
import '../../../common/basewidget/custom_button_widget.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../helper/email_checker_helper.dart';
import '../../../helper/number_checker_helper.dart';
import '../../../localization/language_constrants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../order_details/controllers/order_details_controller.dart';
import '../../profile/screens/profile_screen1.dart';
import '../../splash/controllers/splash_controller.dart';
import '../../splash/domain/models/config_model.dart';
import '../controllers/auth_controller.dart';
import '../domain/models/signup_model.dart';
import '../domain/models/user_log_data.dart';
import '../enums/from_page.dart';
import 'otp_registration_screen.dart';
import 'reset_password_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String? userInput;
  final FromPage fromPage;
  final bool fromDigitalProduct;
  final int? orderId;
  final String? session;

  const VerificationScreen(this.userInput, this.fromPage,
      {super.key, this.session, this.fromDigitalProduct = false, this.orderId});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer? _timer;
  int? _seconds = 0;

  bool? isPhone;

  @override
  void initState() {
    super.initState();
    isPhone = EmailCheckerHelper.isNotValid(widget.userInput.toString());
    _startTimer();
  }

  void _startTimer() {
    // _seconds = (isPhone! &&
    //         Provider.of<SplashController>(context, listen: false)
    //                 .configModel
    //                 ?.customerVerification
    //                 ?.firebase ==
    //             1)
    //     ? 30
    //     : Provider.of<SplashController>(context, listen: false)
    //             .configModel
    //             ?.otpResendTime ??
    //         1;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds! - 1;
      if (_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = (_seconds! / 60).truncate();
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');

    final isPhone = EmailCheckerHelper.isNotValid(widget.userInput.toString());
    final Size size = MediaQuery.of(context).size;
    final ConfigModel config =
        Provider.of<SplashController>(context, listen: false).configModel!;


    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated('otp_verification', context),
        isBackButtonExist: true,
      ),
      body: Consumer<SplashController>(builder: (context, splashProvider, _) {
        return Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Consumer<AuthController>(
                builder: (context, authProvider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.fromDigitalProduct
                        ? CustomAppBar(
                            title: '${getTranslated('verify_otp', context)}')
                        : const SizedBox(),
                    SizedBox(height: size.height * 0.14),
                    CustomAssetImageWidget(
                      isPhone ? Images.phoneOtpSvg : Images.mailOtpSvg,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                        height: Dimensions.paddingSizeExtraOverLarge),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: getTranslated(
                                'we\'ve_sent_verification_code', context),
                            style: titilliumRegular.copyWith(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                          TextSpan(
                            text: " ${widget.userInput} ",
                            style: titilliumRegular.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                          vertical: 35),
                      child: PinCodeTextField(
                        length: 6,
                        appContext: context,
                        obscureText: false,
                        showCursor: true,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 45,
                          fieldWidth: 45,
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(10),
                          selectedColor: ColorResources.colorMap[200],
                          selectedFillColor: Colors.white,
                          inactiveFillColor:
                              ColorResources.getSearchBg(context),
                          inactiveColor: ColorResources.colorMap[200],
                          activeColor: ColorResources.colorMap[400],
                          activeFillColor: ColorResources.getSearchBg(context),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        onChanged: authProvider.updateVerificationCode,
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                    ),
                    if (widget.fromDigitalProduct)
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeLarge),
                          child: CustomButton(
                              buttonText: getTranslated('verify', context),
                              onTap: () {
                                Provider.of<OrderDetailsController>(context,
                                        listen: false)
                                    .verifyDigitalProductOtp(
                                        orderId: widget.orderId!,
                                        otp: authProvider.verificationCode)
                                    .then((value) {
                                  if (value.response?.statusCode == 200) {
                                    Navigator.of(context).pop();
                                  } else {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'input_valid_otp', context),
                                        context,
                                        isError: true);
                                  }
                                });
                              })),
                    if (!widget.fromDigitalProduct)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeLarge),
                        child: (authProvider.isEnableVerificationCode &&
                                !authProvider.resendButtonLoading)
                            ? !authProvider
                                    .isPhoneNumberVerificationButtonLoading
                                ? CustomButton(
                                    buttonText:
                                        getTranslated('verify', context),
                                    backgroundColor:
                                        !authProvider.isEnableVerificationCode
                                            ? Theme.of(context).disabledColor
                                            : null,
                                    onTap: () {
                                      bool phoneVerification = splashProvider
                                              .configModel
                                              ?.forgotPasswordVerification ==
                                          'phone';

                                      if (widget.fromPage == FromPage.login) {
                                
                                  if (isPhone &&
                                              config.phoneVerification==false
                                                ) {
                                            authProvider
                                                .verifyPhone(
                                                    widget.userInput ?? '', '')
                                                .then((value) {
                                              if (value.isSuccess) {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            const DashBoardScreen()),
                                                    (route) => false);
                                              }
                                            });
                                          } else if (!isPhone &&
                                              config.emailVerification==false
                                                 ) {
                                            authProvider
                                                .verifyEmail(
                                                    widget.userInput ?? '')
                                                .then((value) {
                                              if (value.isSuccess) {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            const DashBoardScreen()),
                                                    (route) => false);
                                              }
                                            });
                                          }
                             
                                      } else if (widget.fromPage ==
                                          FromPage.otpLogin) {
                                        print(
                                            "===Session=>>${authProvider.verificationID}");
 
                                          authProvider
                                              .verifyPhoneForOtp(
                                                  widget.userInput ?? '')
                                              .then((value) {
                                            final (responseModel, tempToken) =
                                                value;
                                            if ((responseModel != null &&
                                                    responseModel.isSuccess) &&
                                                tempToken == null) {
                                              if (authProvider
                                                  .isActiveRememberMe) {
                                                String userCountryCode =
                                                    NumberCheckerHelper
                                                        .getCountryCode(
                                                            widget.userInput)!;

                                                authProvider
                                                    .saveUserEmailAndPassword(
                                                        UserLogData(
                                                  countryCode: userCountryCode,
                                                  phoneNumber: widget.userInput
                                                      ?.substring(
                                                          userCountryCode
                                                              .length),
                                                  email: null,
                                                  password: null,
                                                ));
                                              } else {
                                                authProvider
                                                    .clearUserEmailAndPassword();
                                              }
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const DashBoardScreen()),
                                                  (route) => false);
                                            } else if ((responseModel != null &&
                                                    responseModel.isSuccess) &&
                                                tempToken != null) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          OtpRegistrationScreen(
                                                              tempToken:
                                                                  tempToken,
                                                              userInput: widget
                                                                      .userInput ??
                                                                  '')));
                                            }
                                          });
                               
                                      } else if (widget.fromPage ==
                                          FromPage.profile) {
                                        String type =
                                            isPhone ? 'phone' : 'email';
                                        authProvider
                                            .verifyProfileInfo(
                                                widget.userInput!, type)
                                            .then((value) {
                                          if (value.isSuccess) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ProfileScreen1(
                                                                formVerification:
                                                                    true)),
                                                    (route) => false);
                                          }
                                        });
                                      } else {
                       
                                          authProvider
                                              .verifyToken(
                                                  widget.userInput ?? '')
                                              .then((value) {
                                            if (value.isSuccess) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          ResetPasswordScreen(
                                                              mobileNumber:
                                                                  widget.userInput ??
                                                                      '',
                                                              otp: authProvider
                                                                  .verificationCode)));
                                            } else {
                                              showCustomSnackBar(
                                                  value.message!, context);
                                            }
                                          });
                                        
                                      }
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Theme.of(context).primaryColor)))
                            : const SizedBox.shrink(),
                      ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    if (_seconds! <= 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeLarge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getTranslated(
                                'i_didnt_receive_the_code', context)!),
                            authProvider.resendButtonLoading
                                ? const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 02,
                                    ))
                                : InkWell(
                                    onTap: () async {
                                      if (widget.fromPage !=
                                          FromPage.forgetPassword) {
                                        await authProvider.sendVerificationCode(
                                            config,
                                            SignUpModel(
                                              phone: widget.userInput,
                                              email: widget.userInput,
                                            ),
                                            type: isPhone ? 'phone' : 'email',
                                            fromPage: FromPage.verification);
                                        _startTimer();
                                      } else {
                                        bool isNumber =
                                            NumberCheckerHelper.isNumber(
                                                widget.userInput ?? '');
                                        await authProvider
                                            .forgetPassword(
                                                config: config,
                                                phoneOrEmail:
                                                    widget.userInput ?? '',
                                                type:
                                                    isPhone ? 'phone' : 'email')
                                            .then((value) {
                                          if (value!.isSuccess) {
                                            showCustomSnackBar(
                                                getTranslated(
                                                    'resend_code_successful',
                                                    context),
                                                context,
                                                isError: false);
                                          } else {
                                            showCustomSnackBar(
                                                value.message!, context);
                                          }
                                        });
                                        _startTimer();
                                      }
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(
                                            Dimensions.paddingSizeExtraSmall),
                                        child: Text(
                                            getTranslated(
                                                    'resend_code', context) ??
                                                "",
                                            style: robotoBold.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor))))
                          ],
                        ),
                      ),
                    if (_seconds! > 0)
                      Text(
                          '${getTranslated('resend_code', context)} ${getTranslated('after', context)} ${_seconds! > 0 ? '$minutesStr:${_seconds! % 60}' : ''} ${'Sec'}'),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
