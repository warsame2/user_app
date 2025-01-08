import 'dart:io';

import 'package:user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/product_details/domain/repositories/product_details_repository_interface.dart';
import 'package:user_app/utill/app_constants.dart';

class ProductDetailsRepository implements ProductDetailsRepositoryInterface {
  final DioClient? dioClient;
  ProductDetailsRepository({required this.dioClient});

  @override
  Future<ApiResponse> get(String productID) async {
    try {
      final response = await dioClient!
          .get('${AppConstants.productDetailsUri}$productID?guest_id=1');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getCount(String productID) async {
    try {
      final response =
          await dioClient!.get(AppConstants.counterUri + productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getSharableLink(String productID) async {
    try {
      final response =
          await dioClient!.get(AppConstants.socialLinkUri + productID);
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
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<HttpClientResponse> previewDownload(String? url) async {
    HttpClient client = HttpClient();
    final response = await client.getUrl(Uri.parse(url!)).then(
      (HttpClientRequest request) {
        return request.close();
      },
    );
    return response;
  }
}
