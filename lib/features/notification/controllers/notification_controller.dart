import 'package:flutter/material.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/notification/domain/models/notification_model.dart';
import 'package:user_app/features/notification/domain/services/notification_service_interface.dart';
import 'package:user_app/helper/api_checker.dart';

class NotificationController extends ChangeNotifier {
  final NotificationServiceInterface notificationServiceInterface;

  NotificationController({required this.notificationServiceInterface});

  NotificationItemModel? notificationModel;

  Future<void> getNotificationList(int offset) async {
    ApiResponse apiResponse =
        await notificationServiceInterface.getList(offset: offset);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      if (offset == 1) {
        notificationModel =
            NotificationItemModel.fromJson(apiResponse.response?.data);
      } else {
        notificationModel?.notification?.addAll(
            NotificationItemModel.fromJson(apiResponse.response?.data)
                .notification!);
        notificationModel?.offset =
            NotificationItemModel.fromJson(apiResponse.response?.data).offset!;
        notificationModel?.totalSize =
            NotificationItemModel.fromJson(apiResponse.response?.data)
                .totalSize!;
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> seenNotification(int id) async {
    ApiResponse apiResponse =
        await notificationServiceInterface.seenNotification(id);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      getNotificationList(1);
    }
    notifyListeners();
  }
}
