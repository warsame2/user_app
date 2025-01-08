import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/splash/domain/models/config_model.dart';
import 'package:user_app/features/splash/domain/services/splash_service_interface.dart';
import 'package:user_app/helper/api_checker.dart';

import 'package:user_app/utill/app_constants.dart';

class SplashController extends ChangeNotifier {
  final SplashServiceInterface? splashServiceInterface;
  SplashController({required this.splashServiceInterface});

  ConfigModel? _configModel;
  BaseUrls? _baseUrls;
  CurrencyList? _myCurrency;
  CurrencyList? _usdCurrency;
  CurrencyList? _defaultCurrency;
  int? _currencyIndex;
  bool _hasConnection = true;
  bool _fromSetting = false;
  bool _firstTimeConnectionCheck = true;
  bool _onOff = true;
  bool get onOff => _onOff;

  ConfigModel? get configModel => _configModel;
  BaseUrls? get baseUrls => _baseUrls;
  CurrencyList? get myCurrency => _myCurrency;
  CurrencyList? get usdCurrency => _usdCurrency;
  CurrencyList? get defaultCurrency => _defaultCurrency;
  int? get currencyIndex => _currencyIndex;
  bool get hasConnection => _hasConnection;
  bool get fromSetting => _fromSetting;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;


  Future<bool> initConfig(BuildContext context) async {
    // final ThemeController themeController = Provider.of<ThemeController>(context, listen: false);

    _hasConnection = true;
    ApiResponse apiResponse = await splashServiceInterface!.getConfig();
    bool isSuccess;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _configModel = ConfigModel.fromJson(apiResponse.response!.data);
      _baseUrls = ConfigModel.fromJson(apiResponse.response!.data).baseUrls;
      String? currencyCode = splashServiceInterface!.getCurrency();
      await FirebaseMessaging.instance
          .subscribeToTopic(AppConstants.maintenanceModeTopic);

      // themeController.setThemeColor(
      //   primaryColor: ColorHelper.hexCodeToColor(_configModel?.primaryColorCode),
      //   secondaryColor: ColorHelper.hexCodeToColor(_configModel?.secondaryColorCode),
      // );

      for (CurrencyList currencyList in _configModel!.currencyList!) {
        if (currencyList.id == _configModel!.systemDefaultCurrency) {
          if (currencyCode == null || currencyCode.isEmpty) {
            currencyCode = currencyList.code;
          }
          _defaultCurrency = currencyList;
        }
        if (currencyList.code == 'USD') {
          _usdCurrency = currencyList;
        }
      }
      getCurrencyData(currencyCode);

   

      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi(apiResponse);
      if (apiResponse.error.toString() ==
          'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();

    return isSuccess;
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  void getCurrencyData(String? currencyCode) {
    for (var currency in _configModel!.currencyList!) {
      if (currencyCode == currency.code) {
        _myCurrency = currency;
        _currencyIndex = _configModel!.currencyList!.indexOf(currency);
        continue;
      }
    }
  }

  void setCurrency(int index) {
    splashServiceInterface!
        .setCurrency(_configModel!.currencyList![index].code!);
    getCurrencyData(_configModel!.currencyList![index].code);
    notifyListeners();
  }

  void initSharedPrefData() {
    splashServiceInterface!.initSharedData();
  }

  void setFromSetting(bool isSetting) {
    _fromSetting = isSetting;
  }

  bool? showIntro() {
    return splashServiceInterface!.showIntro();
  }

  void disableIntro() {
    splashServiceInterface!.disableIntro();
  }

  void changeAnnouncementOnOff(bool on) {
    _onOff = !_onOff;
    notifyListeners();
  }




}
