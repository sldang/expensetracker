import '../entities/entities.dart';

class Category {
  String categoryId;
  String name;
  int totalExpenses;
  String color;

  Category({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.color,
  });

  static final empty = Category(
      categoryId: '',
      name: '',
      totalExpenses: 0,
      color: ' '
  );

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      totalExpenses: totalExpenses,
      color: color,
    );
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      categoryId: entity.categoryId,
      name: entity.name,
      totalExpenses: entity.totalExpenses,
      color: entity.color,
    );
  }
}