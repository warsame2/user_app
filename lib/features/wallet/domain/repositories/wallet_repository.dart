import 'package:dio/dio.dart';
import 'package:user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/splash/controllers/splash_controller.dart';
import 'package:user_app/features/wallet/domain/repositories/wallet_repository_interface.dart';
import 'package:user_app/main.dart';
import 'package:user_app/utill/app_constants.dart';
import 'package:provider/provider.dart';

class WalletRepository implements WalletRepositoryInterface {
  final DioClient? dioClient;
  WalletRepository({required this.dioClient});

  @override
  Future<ApiResponse> getWalletTransactionList(int offset, String type) async {
    try {
      Response response = await dioClient!.get(
          '${AppConstants.walletTransactionUri}$offset&transaction_type=$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> addFundToWallet(
      String amount, String paymentMethod) async {
    try {
      final response =
          await dioClient!.post(AppConstants.addFundToWallet, data: {
        'payment_platform': 'app',
        'payment_method': paymentMethod,
        'payment_request_from': 'app',
        'amount': amount,
        'current_currency_code':
            Provider.of<SplashController>(Get.context!, listen: false)
                .myCurrency!
                .code
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getWalletBonusBannerList() async {
    try {
      Response response = await dioClient!.get(AppConstants.walletBonusList);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
