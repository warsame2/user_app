import 'package:user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/banner/domain/repositories/banner_repository_interface.dart';
import 'package:user_app/utill/app_constants.dart';

class BannerRepository implements BannerRepositoryInterface {
  final DioClient? dioClient;
  BannerRepository({required this.dioClient});

  @override
  Future<ApiResponse> getList({int? offset}) async {
    try {
      final response = await dioClient!.get(AppConstants.getBannerList);
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
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
