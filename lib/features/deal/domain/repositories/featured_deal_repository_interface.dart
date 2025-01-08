import 'package:user_app/interface/repo_interface.dart';

abstract class FeaturedDealRepositoryInterface implements RepositoryInterface {
  Future<dynamic> getFeaturedDeal();
}
