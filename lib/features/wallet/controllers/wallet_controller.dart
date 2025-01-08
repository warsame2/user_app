import 'package:flutter/material.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/wallet/domain/models/transaction_model.dart';
import 'package:user_app/features/wallet/domain/models/wallet_bonus_model.dart';
import 'package:user_app/features/wallet/domain/services/wallet_service_interface.dart';
import 'package:user_app/features/wallet/screens/add_fund_to_wallet_screen.dart';
import 'package:user_app/helper/api_checker.dart';
import 'package:user_app/helper/price_converter.dart';
import 'package:user_app/main.dart';
import 'package:user_app/common/basewidget/show_custom_snakbar_widget.dart';

class WalletController extends ChangeNotifier {
  final WalletServiceInterface walletServiceInterface;
  WalletController({required this.walletServiceInterface});

  bool _isLoading = false;
  bool _firstLoading = false;
  bool _isConvert = false;
  bool get isConvert => _isConvert;
  bool get isLoading => _isLoading;
  bool get firstLoading => _firstLoading;
  int? _transactionPageSize;
  int? get transactionPageSize => _transactionPageSize;
  TransactionModel? _walletTransactionModel;
  TransactionModel? get walletTransactionModel => _walletTransactionModel;

  Future<void> getTransactionList(BuildContext context, int offset, String type,
      {bool reload = true}) async {
    if (reload || offset == 1) {
      _walletTransactionModel = null;
    }
    ApiResponse apiResponse =
        await walletServiceInterface.getWalletTransactionList(offset, type);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      if (offset == 1) {
        _walletTransactionModel =
            TransactionModel.fromJson(apiResponse.response!.data);
      } else {
        _walletTransactionModel?.offset =
            TransactionModel.fromJson(apiResponse.response!.data).offset;
        _walletTransactionModel?.totalWalletBalance =
            TransactionModel.fromJson(apiResponse.response!.data)
                .totalWalletBalance;
        _walletTransactionModel?.totalWalletTransactio =
            TransactionModel.fromJson(apiResponse.response!.data)
                .totalWalletTransactio;
        _walletTransactionModel?.walletTransactioList?.addAll(
            TransactionModel.fromJson(apiResponse.response!.data)
                    .walletTransactioList ??
                []);
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  void showBottomLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }

  Future<void> addFundToWallet(String amount, String paymentMethod) async {
    _isConvert = true;
    notifyListeners();
    ApiResponse apiResponse =
        await walletServiceInterface.addFundToWallet(amount, paymentMethod);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isConvert = false;
      Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(
              builder: (_) => AddFundToWalletScreen(
                  url: apiResponse.response!.data['redirect_link'])));
    } else if (apiResponse.response?.statusCode == 202) {
      showCustomSnackBar(
          "Minimum= ${PriceConverter.convertPrice(Get.context!, apiResponse.response?.data['minimum_amount'])} and Maximum=${PriceConverter.convertPrice(Get.context!, apiResponse.response?.data['maximum_amount'].toDouble())}",
          Get.context!);
    } else {
      _isConvert = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  WalletBonusModel? walletBonusModel;
  Future<void> getWalletBonusBannerList() async {
    ApiResponse apiResponse =
        await walletServiceInterface.getWalletBonusBannerList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      walletBonusModel = WalletBonusModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  int currentIndex = 0;
  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<String> types = [
    'all',
    'order_place',
    'loyalty_point',
    'add_fund',
    'add_fund_by_admin',
    'order_refund'
  ];
  List<String> filterTypes = [
    "All Transaction",
    "Order Transactions",
    "Converted from Loyalty Point",
    'Added via Payment Method',
    'Add Fund by Admin',
    'Order refund'
  ];

  String selectedFilterType = 'all_transaction';
  int selectedIndexForFilter = 0;
  void setSelectedFilterType(String type, int index, {bool reload = true}) {
    selectedIndexForFilter = index;
    if (type == filterTypes[0]) {
      selectedFilterType = types[0];
    } else if (type == filterTypes[1]) {
      selectedFilterType = types[1];
    } else if (type == filterTypes[2]) {
      selectedFilterType = types[2];
    } else if (type == filterTypes[3]) {
      selectedFilterType = types[3];
    } else if (type == filterTypes[4]) {
      selectedFilterType = types[4];
    } else if (type == filterTypes[5]) {
      selectedFilterType = types[5];
    }
    getTransactionList(Get.context!, 1, selectedFilterType);

    if (reload) {
      notifyListeners();
    }
  }
}
