import 'package:user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/brand/domain/repositories/brand_repo_interface.dart';
import 'package:user_app/utill/app_constants.dart';

class BrandRepository implements BrandRepoInterface {
  final DioClient? dioClient;
  BrandRepository({required this.dioClient});

  @override
  Future<ApiResponse> getList({int? offset}) async {
    try {
      final response = await dioClient!.get(AppConstants.brandUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getSellerWiseBrandList(int sellerId) async {
    try {
      final response =
          await dioClient!.get('${AppConstants.sellerWiseBrandList}$sellerId');
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
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
