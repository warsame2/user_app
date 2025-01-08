import 'package:user_app/interface/repo_interface.dart';

abstract class LoyaltyPointRepositoryInterface implements RepositoryInterface {
  Future<dynamic> convertPointToCurrency(int point);
}
