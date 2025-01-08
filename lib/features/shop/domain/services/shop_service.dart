import 'package:user_app/features/shop/domain/repositories/shop_repository_interface.dart';
import 'package:user_app/features/shop/domain/services/shop_service_interface.dart';

class ShopService implements ShopServiceInterface {
  ShopRepositoryInterface shopRepositoryInterface;

  ShopService({required this.shopRepositoryInterface});

  @override
  Future getMoreStore() async {
    return await shopRepositoryInterface.getMoreStore();
  }

  @override
  Future getSellerList(String type, int offset) async {
    return await shopRepositoryInterface.getSellerList(type, offset);
  }

  @override
  Future get(String id) async {
    return await shopRepositoryInterface.get(id);
  }
}
