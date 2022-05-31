class CategoryModel {
  final String? name;
  final String? numberOfProducts;

  CategoryModel({
    this.name,
    this.numberOfProducts,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        numberOfProducts: json["numberOfProducts"],
      );
}
