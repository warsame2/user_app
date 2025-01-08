import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/auth/controllers/auth_controller.dart';
import 'package:user_app/features/checkout/domain/services/checkout_service_interface.dart';
import 'package:user_app/features/offline_payment/domain/models/offline_payment_model.dart';
import 'package:user_app/helper/api_checker.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/main.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user_app/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:user_app/features/checkout/screens/digital_payment_order_place_screen.dart';
import 'package:provider/provider.dart';

class CheckoutController with ChangeNotifier {
  final CheckoutServiceInterface checkoutServiceInterface;
  CheckoutController({required this.checkoutServiceInterface});

  int? _addressIndex;
  int? _billingAddressIndex;
  int? get billingAddressIndex => _billingAddressIndex;
  int? _shippingIndex;
  bool _isLoading = false;
  bool _isCheckCreateAccount = false;
  bool _newUser = false;

  int _paymentMethodIndex = -1;
  bool _onlyDigital = true;
  bool get onlyDigital => _onlyDigital;
  int? get addressIndex => _addressIndex;
  int? get shippingIndex => _shippingIndex;
  bool get isLoading => _isLoading;
  int get paymentMethodIndex => _paymentMethodIndex;
  bool get isCheckCreateAccount => _isCheckCreateAccount;

  String selectedPaymentName = '';
  void setSelectedPayment(String payment) {
    selectedPaymentName = payment;
    notifyListeners();
  }

  final TextEditingController orderNoteController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  List<String> inputValueList = [];

  Future<void> placeOrder(
      {required Function callback,
      String? addressID,
      String? couponCode,
      String? couponAmount,
      String? billingAddressId,
      String? orderNote,
      String? transactionId,
      String? paymentNote,
      int? id,
      String? name,
      bool isfOffline = false,
      bool wallet = false}) async {
    for (TextEditingController textEditingController
        in inputFieldControllerList) {
      inputValueList.add(textEditingController.text.trim());
    }

    _isLoading = true;
    _newUser = false;
    notifyListeners();
    ApiResponse apiResponse;
    isfOffline
        ? apiResponse = await checkoutServiceInterface.offlinePaymentPlaceOrder(
            addressID,
            couponCode,
            couponAmount,
            billingAddressId,
            orderNote,
            keyList,
            inputValueList,
            offlineMethodSelectedId,
            offlineMethodSelectedName,
            paymentNote,
            _isCheckCreateAccount,
            passwordController.text.trim())
        : wallet
            ? apiResponse =
                await checkoutServiceInterface.walletPaymentPlaceOrder(
                    addressID,
                    couponCode,
                    couponAmount,
                    billingAddressId,
                    orderNote,
                    _isCheckCreateAccount,
                    passwordController.text.trim())
            : apiResponse =
                await checkoutServiceInterface.cashOnDeliveryPlaceOrder(
                    addressID,
                    couponCode,
                    couponAmount,
                    billingAddressId,
                    orderNote,
                    _isCheckCreateAccount,
                    passwordController.text.trim());

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isCheckCreateAccount = false;
      _isLoading = false;
      _addressIndex = null;
      _billingAddressIndex = null;
      sameAsBilling = false;
      if (!Provider.of<AuthController>(Get.context!, listen: false)
          .isLoggedIn()) {
        _newUser = apiResponse.response!.data['new_user'];
      }

      String message = apiResponse.response!.data.toString();
      callback(true, message, '', _newUser);
    } else {
      _isLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  void setAddressIndex(int index) {
    _addressIndex = index;
    notifyListeners();
  }

  void setBillingAddressIndex(int index) {
    _billingAddressIndex = index;
    notifyListeners();
  }

  void resetPaymentMethod() {
    _paymentMethodIndex = -1;
    codChecked = false;
    walletChecked = false;
    offlineChecked = false;
  }

  void shippingAddressNull() {
    _addressIndex = null;
    notifyListeners();
  }

  void billingAddressNull() {
    _billingAddressIndex = null;
    notifyListeners();
  }

  void setSelectedShippingAddress(int index) {
    _shippingIndex = index;
    notifyListeners();
  }

  void setSelectedBillingAddress(int index) {
    _billingAddressIndex = index;
    notifyListeners();
  }

  bool offlineChecked = false;
  bool codChecked = false;
  bool walletChecked = false;

  void setOfflineChecked(String type) {
    if (type == 'offline') {
      offlineChecked = !offlineChecked;
      codChecked = false;
      walletChecked = false;
      _paymentMethodIndex = -1;
      setOfflinePaymentMethodSelectedIndex(0);
    } else if (type == 'cod') {
      codChecked = !codChecked;
      offlineChecked = false;
      walletChecked = false;
      _paymentMethodIndex = -1;
    } else if (type == 'wallet') {
      walletChecked = !walletChecked;
      offlineChecked = false;
      codChecked = false;
      _paymentMethodIndex = -1;
    }

    notifyListeners();
  }

  String selectedDigitalPaymentMethodName = '';

  void setDigitalPaymentMethodName(int index, String name) {
    _paymentMethodIndex = index;
    selectedDigitalPaymentMethodName = name;
    codChecked = false;
    walletChecked = false;
    offlineChecked = false;
    notifyListeners();
  }

  void digitalOnly(bool value, {bool isUpdate = false}) {
    _onlyDigital = value;
    if (isUpdate) {
      notifyListeners();
    }
  }

  OfflinePaymentModel? offlinePaymentModel;
  Future<ApiResponse> getOfflinePaymentList() async {
    ApiResponse apiResponse =
        await checkoutServiceInterface.offlinePaymentList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      offlineMethodSelectedIndex = 0;
      offlinePaymentModel =
          OfflinePaymentModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  List<TextEditingController> inputFieldControllerList = [];
  List<String?> keyList = [];
  int offlineMethodSelectedIndex = -1;
  int offlineMethodSelectedId = 0;
  String offlineMethodSelectedName = '';

  void setOfflinePaymentMethodSelectedIndex(int index, {bool notify = true}) {
    keyList = [];
    inputFieldControllerList = [];
    offlineMethodSelectedIndex = index;
    if (offlinePaymentModel != null &&
        offlinePaymentModel!.offlineMethods != null &&
        offlinePaymentModel!.offlineMethods!.isNotEmpty) {
      offlineMethodSelectedId =
          offlinePaymentModel!.offlineMethods![offlineMethodSelectedIndex].id!;
      offlineMethodSelectedName = offlinePaymentModel!
          .offlineMethods![offlineMethodSelectedIndex].methodName!;
    }

    if (offlinePaymentModel!.offlineMethods != null &&
        offlinePaymentModel!.offlineMethods!.isNotEmpty &&
        offlinePaymentModel!
            .offlineMethods![index].methodInformations!.isNotEmpty) {
      for (int i = 0;
          i <
              offlinePaymentModel!
                  .offlineMethods![index].methodInformations!.length;
          i++) {
        inputFieldControllerList.add(TextEditingController());
        keyList.add(offlinePaymentModel!
            .offlineMethods![index].methodInformations![i].customerInput);
      }
    }
    if (notify) {
      notifyListeners();
    }
  }

  Future<ApiResponse> digitalPaymentPlaceOrder(
      {String? orderNote,
      String? customerId,
      String? addressId,
      String? billingAddressId,
      String? couponCode,
      String? couponDiscount,
      String? paymentMethod}) async {
    _isLoading = true;

    ApiResponse apiResponse =
        await checkoutServiceInterface.digitalPaymentPlaceOrder(
            orderNote,
            customerId,
            addressId,
            billingAddressId,
            couponCode,
            couponDiscount,
            paymentMethod,
            _isCheckCreateAccount,
            passwordController.text.trim());
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _addressIndex = null;
      _billingAddressIndex = null;
      sameAsBilling = false;
      _isLoading = false;
      Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(
              builder: (_) => DigitalPaymentScreen(
                  url: apiResponse.response?.data['redirect_link'])));
    } else if (apiResponse.error == 'Already registered ') {
      _isLoading = false;
      showCustomSnackBar(
          '${getTranslated(apiResponse.error, Get.context!)}', Get.context!);
    } else {
      _isLoading = false;
      showCustomSnackBar(
          '${getTranslated('payment_method_not_properly_configured', Get.context!)}',
          Get.context!);
    }
    notifyListeners();
    return apiResponse;
  }

  bool sameAsBilling = false;
  void setSameAsBilling() {
    sameAsBilling = !sameAsBilling;
    notifyListeners();
  }

  void clearData() {
    orderNoteController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _isCheckCreateAccount = false;
  }

  void setIsCheckCreateAccount(bool isCheck, {bool update = true}) {
    _isCheckCreateAccount = isCheck;
    if (update) {
      notifyListeners();
    }
  }
}
