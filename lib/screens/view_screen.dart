import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/data.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Color(0xFF7F7FD5),
      ),
      body: ListView.builder(
        itemCount: transactionData.length,
        itemBuilder: (context, int i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: transactionData[i]['color'],
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            transactionData[i]['icon']
                          ],
                        ),
                        const SizedBox(width: 12),
                        Text(
                            transactionData[i]['name'],
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            )
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            transactionData[i]['totalAmount'],
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400
                            )
                        ),
                        Text(
                            transactionData[i]['date'],
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
