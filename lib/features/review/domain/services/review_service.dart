import 'dart:io';
import 'package:user_app/features/review/domain/models/review_body.dart';
import 'package:user_app/features/review/domain/repositories/review_repository_interface.dart';
import 'package:user_app/features/review/domain/services/review_service_interface.dart';

class ReviewService implements ReviewServiceInterface {
  ReviewRepositoryInterface reviewRepositoryInterface;
  ReviewService({required this.reviewRepositoryInterface});

  @override
  Future get(String id) async {
    return reviewRepositoryInterface.get(id);
  }

  @override
  Future submitReview(
      ReviewBody reviewBody, List<File> files, bool update) async {
    return reviewRepositoryInterface.submitReview(reviewBody, files, update);
  }

  @override
  Future deleteOrderWiseReviewImage(String id, String name) {
    return reviewRepositoryInterface.deleteOrderWiseReviewImage(id, name);
  }

  @override
  Future getOrderWiseReview(String productID, String orderId) {
    return reviewRepositoryInterface.getOrderWiseReview(productID, orderId);
  }
}
