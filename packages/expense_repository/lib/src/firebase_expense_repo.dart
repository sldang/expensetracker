import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'dart:async';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'getOrCreateUserId.dart';

class FirebaseExpenseRepo implements ExpenseRepository {
  late final Future<void> _init;
  late CollectionReference categoryCollection;
  late CollectionReference expenseCollection;

  FirebaseExpenseRepo() {
    _init = _initialize();
  }

  Future<void> _initialize() async {
    final String userId = await getOrCreateUserId(); // Ensure this function is correctly implemented and accessible
    categoryCollection = FirebaseFirestore.instance.collection('users/$userId/categories');
    expenseCollection = FirebaseFirestore.instance.collection('users/$userId/expenses');
  }

  // The `getOrCreateUserId` function is assumed to be implemented elsewhere

  @override
  Future<void> createCategory(Category category) async {
    await _init; // Ensure initialization is complete
    try {
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    await _init; // Ensure initialization is complete.
    try {
      final QuerySnapshot querySnapshot = await categoryCollection.get();
      final List<Category> categories = querySnapshot.docs.map((doc) {
        // Directly use the data as Map<String, dynamic> for fromDocument.
        final CategoryEntity categoryEntity = CategoryEntity.fromDocument(
            doc.data() as Map<String, dynamic>);
        return Category.fromEntity(
            categoryEntity); // Assuming you have a method to convert Entity to Model.
      }).toList();

      return categories;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createExpense(Expense expense) async {
    await _init; // Ensure initialization is complete.
    try {
      final ExpenseEntity expenseEntity = expense
          .toEntity(); // Assuming you have a toEntity method in Expense model
      await expenseCollection.doc(expenseEntity.expenseId).set(
          expenseEntity.toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  @override
  Future<List<Expense>> getExpenses() async {
    await _init; // Ensure initialization is complete.
    try {
      final QuerySnapshot querySnapshot = await expenseCollection.get();
      final List<Expense> expenses = querySnapshot.docs.map((doc) {
        // Ensure the cast is safe; otherwise, handle potential casting errors.
        final ExpenseEntity expenseEntity = ExpenseEntity.fromDocument(
            doc.data() as Map<String, dynamic>);
        return Expense.fromEntity(
            expenseEntity); // Convert to domain model if necessary
      }).toList();

      return expenses;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
