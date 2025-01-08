import 'package:user_app/interface/repo_interface.dart';

abstract class CategoryRepoInterface extends RepositoryInterface {
  Future<dynamic> getSellerWiseCategoryList(int sellerId);
}
