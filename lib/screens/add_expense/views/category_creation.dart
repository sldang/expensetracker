import 'package:expense_repository/expense_repository.dart';
import 'package:expensetracker/screens/add_expense/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';

Future getCategoryCreation(BuildContext context) {
  return showDialog(
      context: context,
      builder: (ctx) {
        Color categoryColor = Colors.white;
        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        bool isLoading = false;
        Category category = Category.empty;

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: StatefulBuilder(
          builder: (ctx,setState){
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategorySuccess) {
                  Navigator.pop(ctx, category);
                } else if (state is CreateCategoryLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: AlertDialog(
                title: const Text(
                    "Create a Category"
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16,),
                       SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: categoryNameController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                      ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: categoryColorController,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx2) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                      pickerColor: categoryColor,
                                      onColorChanged: (value) {
                                        setState(() {
                                          categoryColor = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(ctx2);
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor: Theme.of(context).colorScheme.primary,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12)
                                              )
                                          ),
                                          child: const Text(
                                            "Save Color",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white
                                            ),
                                          )
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        );
                      },
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: categoryColor,
                          hintText: "Color",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius
                                  .circular(10),
                              borderSide: BorderSide.none
                          )
                      ),
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      width: double.infinity,
                      height: kToolbarHeight,
                      child: isLoading == true
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : TextButton(
                          onPressed: () {
                            // create category object and pop
                            setState(() {
                              category.categoryId = const Uuid().v1();
                              category.name = categoryNameController.text;
                              category.color = categoryColor.value;
                            });
                            context.read<CreateCategoryBloc>().add(CreateCategory(category));
                            //Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              )
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
            );
            },
          ),
        );
      }
  );
}