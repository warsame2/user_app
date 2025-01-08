import 'package:flutter/material.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/loyaltyPoint/domain/models/loyalty_point_model.dart';
import 'package:user_app/features/loyaltyPoint/domain/services/loyalty_point_service_interface.dart';
import 'package:user_app/helper/api_checker.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/common/basewidget/show_custom_snakbar_widget.dart';

class LoyaltyPointController extends ChangeNotifier {
  final LoyaltyPointServiceInterface loyaltyPointServiceInterface;
  LoyaltyPointController({required this.loyaltyPointServiceInterface});

  bool _isConvert = false;
  bool get isConvert => _isConvert;

  LoyaltyPointModel? _loyaltyPointModel;
  LoyaltyPointModel? get loyaltyPointModel => _loyaltyPointModel;

  Future<void> getLoyaltyPointList(BuildContext context, int offset,
      {bool reload = false}) async {
    if (reload || offset == 1) {
      _loyaltyPointModel = null;
    }

    ApiResponse apiResponse =
        await loyaltyPointServiceInterface.getList(offset: offset);
    if (apiResponse.response?.data != null &&
        apiResponse.response?.statusCode == 200) {
      if (offset == 1) {
        _loyaltyPointModel =
            LoyaltyPointModel.fromJson(apiResponse.response?.data);
      } else {
        _loyaltyPointModel?.offset =
            LoyaltyPointModel.fromJson(apiResponse.response?.data).offset;
        _loyaltyPointModel?.totalLoyaltyPoint =
            LoyaltyPointModel.fromJson(apiResponse.response?.data)
                .totalLoyaltyPoint;
        _loyaltyPointModel?.loyaltyPointList?.addAll(
            LoyaltyPointModel.fromJson(apiResponse.response?.data)
                    .loyaltyPointList ??
                []);
      }
    } else {
      _loyaltyPointModel?.loyaltyPointList = [];
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future convertPointToCurrency(BuildContext context, int point) async {
    _isConvert = true;
    notifyListeners();
    ApiResponse apiResponse =
        await loyaltyPointServiceInterface.convertPointToCurrency(point);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _isConvert = false;
      showCustomSnackBar(
          "${getTranslated('point_converted_successfully', Get.context!)}",
          Get.context!,
          isError: false);
    } else {
      _isConvert = false;
      showCustomSnackBar(
          "${getTranslated('point_converted_failed', Get.context!)}",
          Get.context!);
    }
    notifyListeners();
  }

  int currentIndex = 0;
  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
