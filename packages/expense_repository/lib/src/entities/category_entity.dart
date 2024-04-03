class CategoryEntity {
  String categoryId;
  String name;
  int totalExpenses;
  String color;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.color,
  });

  Map<String, Object?> toDocument() {
    return {
      'categoryId': categoryId,
      'name': name,
      'totalExpenses': totalExpenses,
      'color': color
    };
  }

  static CategoryEntity fromDocument(Map<String, dynamic> doc) {
    return CategoryEntity(
      categoryId: doc['categoryId'],
      name: doc['name'],
      totalExpenses: doc['totalExpenses'],
      color: doc['color']
    );
  }
}