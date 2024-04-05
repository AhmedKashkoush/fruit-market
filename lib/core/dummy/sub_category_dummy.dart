import 'package:fruit_market/features/products/data/models/sub_category_model.dart';

final class SubCategoryDummy {
  static const List<SubCategoryModel> subCategories = [
    SubCategoryModel(
      id: '1',
      categoryId: '1',
      name: 'Organic Vegetables',
      description: 'Pick up from organic farms',
      sale: 0.2,
    ),
    SubCategoryModel(
      id: '2',
      categoryId: '1',
      name: 'Mixed Vegetables Pack',
      description: 'Vegetables mix fresh pack',
      sale: 0.1,
    ),
    // SubCategoryModel(
    //   id: '3',
    //   categoryId: '1',
    //   name: 'Allium Vegetables',
    //   description: 'Fresh allium vegetables',
    //   sale: 0.05,
    // ),
    // SubCategoryModel(
    //   id: '4',
    //   categoryId: '1',
    //   name: 'Root Vegetables',
    //   description: 'Fresh root vegetables',
    //   sale: 0.0,
    // ),
  ];
}
