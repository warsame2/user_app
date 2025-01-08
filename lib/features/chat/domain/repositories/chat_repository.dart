import 'package:file_picker/file_picker.dart';
import 'package:user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:user_app/features/chat/domain/models/message_body.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/chat/domain/repositories/chat_repository_interface.dart';
import 'package:user_app/main.dart';
import 'package:user_app/features/auth/controllers/auth_controller.dart';
import 'package:user_app/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ChatRepository implements ChatRepositoryInterface {
  final DioClient? dioClient;
  ChatRepository({required this.dioClient});

  @override
  Future<ApiResponse> getChatList(String type, int offset) async {
    try {
      final response = await dioClient!
          .get('${AppConstants.chatInfoUri}$type?limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> searchChat(String type, String search) async {
    try {
      final response = await dioClient!
          .get('${AppConstants.searchChat}$type?search=$search');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getMessageList(String type, int? id, int offset) async {
    try {
      final response = await dioClient!
          .get('${AppConstants.messageUri}$type/$id?limit=3000&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> seenMessage(int id, String type) async {
    try {
      final response = await dioClient!
          .post('${AppConstants.seenMessageUri}$type', data: {'id': id});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<http.StreamedResponse> sendMessage(MessageBody messageBody,
      String type, List<XFile?> file, List<PlatformFile>? platformFile) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${AppConstants.baseUrl}${AppConstants.sendMessageUri}$type'));

    print("===Request===>>${request.url}");
    request.headers.addAll(<String, String>{
      'Authorization':
          'Bearer ${Provider.of<AuthController>(Get.context!, listen: false).getUserToken()}'
    });
    for (int i = 0; i < file.length; i++) {
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile(
          'image[]', file[i]!.readAsBytes().asStream(), list.length,
          filename: basename(file[i]!.path),
          contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }

    if (platformFile != null) {
      if (platformFile.isNotEmpty) {
        for (PlatformFile pfile in platformFile) {
          request.files.add(http.MultipartFile(
              'file[]', pfile.readStream!, pfile.size,
              filename: basename(pfile.name)));
        }
      }
    }

    Map<String, String> fields = {};
    request.fields.addAll(<String, String>{
      'id': messageBody.id.toString(),
      'message': messageBody.message ?? ''
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
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
  Future getList({int? offset}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
