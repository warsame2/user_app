import 'package:user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/compare/domain/repositories/compare_repository_interface.dart';
import 'package:user_app/utill/app_constants.dart';

class CompareRepository implements CompareRepositoryInterface {
  final DioClient? dioClient;
  CompareRepository({required this.dioClient});

  @override
  Future<ApiResponse> getList({int? offset}) async {
    try {
      final response = await dioClient!.get(AppConstants.getCompareList);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> addCompareProductList(int id) async {
    try {
      final response = await dioClient!
          .post(AppConstants.addToCompareList, data: {'product_id': id});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> removeAllCompareProductList() async {
    try {
      final response = await dioClient!.post(
          AppConstants.removeAllFromCompareList,
          data: {'_method': 'delete'});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> replaceCompareProductList(
      int compareId, int productId) async {
    try {
      final response = await dioClient!.get(
          '${AppConstants.replaceFromCompareList}?compare_id=$compareId&product_id=$productId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getAttributeList() async {
    try {
      final response = await dioClient!.get(AppConstants.attributeUri);
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
