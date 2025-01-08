import 'package:flutter/material.dart';
import 'package:user_app/data/model/api_response.dart';
import 'package:user_app/features/brand/domain/models/brand_model.dart';
import 'package:user_app/features/brand/domain/repositories/brand_repository.dart';

class BrandController extends ChangeNotifier {
  final BrandRepository? brandRepo;
  BrandController({required this.brandRepo});

  List<BrandModel> _brandList = [];
  List<BrandModel> get brandList => _brandList;
  final List<BrandModel> _originalBrandList = [];

  Future<void> getBrandList(bool reload) async {
    if (_brandList.isEmpty || reload) {
      ApiResponse apiResponse = await brandRepo!.getList();
      _originalBrandList.clear();
      apiResponse.response?.data.forEach(
          (brand) => _originalBrandList.add(BrandModel.fromJson(brand)));
      _brandList.clear();
      apiResponse.response!.data
          .forEach((brand) => _brandList.add(BrandModel.fromJson(brand)));

      notifyListeners();
    }
  }

  Future<void> getSellerWiseBrandList(int sellerId) async {
    ApiResponse apiResponse = await brandRepo!.getSellerWiseBrandList(sellerId);
    _originalBrandList.clear();
    apiResponse.response!.data
        .forEach((brand) => _originalBrandList.add(BrandModel.fromJson(brand)));
    _brandList.clear();
    apiResponse.response!.data
        .forEach((brand) => _brandList.add(BrandModel.fromJson(brand)));

    notifyListeners();
  }

  final List<int> _selectedBrandIds = [];
  List<int> get selectedBrandIds => _selectedBrandIds;

  void checkedToggleBrand(int index) {
    _brandList[index].checked = !_brandList[index].checked!;

    if (_brandList[index].checked ?? false) {
      if (!_selectedBrandIds.contains(index)) {
        _selectedBrandIds.add(index);
      }
    } else {
      _selectedBrandIds.remove(index);
    }
    notifyListeners();
  }

  bool isTopBrand = true;
  bool isAZ = false;
  bool isZA = false;

  void sortBrandLis(int value) {
    if (value == 0) {
      _brandList.clear();
      _brandList.addAll(_originalBrandList);
      isTopBrand = true;
      isAZ = false;
      isZA = false;
    } else if (value == 1) {
      _brandList.clear();
      _brandList.addAll(_originalBrandList);
      _brandList.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      isTopBrand = false;
      isAZ = true;
      isZA = false;
    } else if (value == 2) {
      _brandList.clear();
      _brandList.addAll(_originalBrandList);
      _brandList.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      Iterable iterable = _brandList.reversed;
      _brandList = iterable.toList() as List<BrandModel>;
      isTopBrand = false;
      isAZ = false;
      isZA = true;
    }

    notifyListeners();
  }
}
