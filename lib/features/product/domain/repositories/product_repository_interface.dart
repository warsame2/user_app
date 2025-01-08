import 'package:flutter/material.dart';
import 'package:user_app/features/product/enums/product_type.dart';
import 'package:user_app/interface/repo_interface.dart';

abstract class ProductRepositoryInterface<T> extends RepositoryInterface {
  Future<dynamic> getFilteredProductList(BuildContext context, String offset,
      ProductType productType, String? title);
  Future<dynamic> getBrandOrCategoryProductList(bool isBrand, String id);
  Future<dynamic> getRelatedProductList(String id);
  Future<dynamic> getFeaturedProductList(String offset);
  Future<dynamic> getLatestProductList(String offset);
  Future<dynamic> getRecommendedProduct();
  Future<dynamic> getMostDemandedProduct();
  Future<dynamic> getFindWhatYouNeed();
  Future<dynamic> getJustForYouProductList();
  Future<dynamic> getMostSearchingProductList(int offset);
  Future<dynamic> getHomeCategoryProductList();
}
