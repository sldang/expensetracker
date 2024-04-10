import 'package:cloud_firestore/cloud_firestore.dart';

import '../../expense_repository.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  DateTime date;
  int amount;
  bool isIncome;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
    required this.isIncome,
  });

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'category': category.toEntity().toDocument(),
      'date': date,
      'amount': amount,
      'isIncome': isIncome,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
        expenseId: doc['expenseId'],
        category: Category.fromEntity(CategoryEntity.fromDocument(doc['category'])),
        date: (doc['date'] as Timestamp).toDate(),
        amount: doc['amount'],
        isIncome: doc['isIncome'],
    );
  }
}