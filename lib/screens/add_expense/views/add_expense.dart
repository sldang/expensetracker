import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

class  AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();

  //late Color categoryColor = Colors.white;

  @override
  void initState() {
    dateController.text = DateFormat('MM/dd/yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Add Expenses",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: expenseController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              const SizedBox(height: 32,),
              TextFormField(
                controller: categoryController,
                readOnly: true,
                onTap: (){

                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.view_list,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                               Color categoryColor = Colors.white;
                              return StatefulBuilder(
                                builder: (context,setState){
                                 return AlertDialog(
                                   title: const Text(
                                       "Create a Category"
                                   ),
                                   content: Column(
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       const SizedBox(height: 16,),
                                       SizedBox(
                                         width: MediaQuery
                                             .of(context)
                                             .size
                                             .width,
                                         child: TextFormField(
                                           //controller: dateController,
                                           textAlignVertical: TextAlignVertical
                                               .center,
                                           decoration: InputDecoration(
                                               isDense: true,
                                               filled: true,
                                               fillColor: Colors.white,
                                               hintText: "Name",
                                               border: OutlineInputBorder(
                                                   borderRadius: BorderRadius
                                                       .circular(10),
                                                   borderSide: BorderSide.none
                                               )
                                           ),
                                         ),
                                       ),
                                       const SizedBox(height: 16,),
                                       TextFormField(
                                         //controller: dateController,
                                         onTap: () {
                                           showDialog(
                                               context: context,
                                               builder: (ctx2) {
                                                 return AlertDialog(
                                                   content: Column(
                                                     mainAxisSize: MainAxisSize
                                                         .min,
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
                                                 );
                                               }
                                           );
                                         },
                                         textAlignVertical: TextAlignVertical
                                             .center,
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
                                         child: TextButton(
                                             onPressed: () {
                                               // create category object and pop

                                               Navigator.pop(context);
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
                                 );
                               });
                            }
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.grey,
                      )
                    ),
                    hintText: "Category",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    )
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: dateController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () async{
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days:365))
                  );

                  if(newDate != null) {
                    setState(() {
                      dateController.text = DateFormat('MM/dd/yyyy').format(newDate);
                      selectDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.date_range_outlined,
                      color: Colors.grey,
                    ),
                    hintText: "Date",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    )
                ),
              ),
              const SizedBox(height: 32,),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                    onPressed: () {},
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
      ),
    );
  }
}
