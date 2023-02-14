import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/widgets.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: payrollList.length,
        itemBuilder: (context, index) {
          final employees = payrollList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: GestureDetector(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 130),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Branch',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12.5),
                                ),
                                Text(
                                  employees['name']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'ID: ${employees['id']!}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    payrollDetails(
                                        'Account: ', employees['allowance']),
                                    kSizedBoxW4,
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text(
                                        'Paid',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                kSizedBoxH4,
                                Row(
                                  children: [
                                    payrollDetails(
                                        'MPesa: ', employees['allowance']),
                                    kSizedBoxW4,
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text(
                                        'Paid',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                kSizedBoxH4,
                                Row(
                                  children: [
                                    payrollDetails(
                                        'MyCash: ', employees['allowance']),
                                    kSizedBoxW4,
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text(
                                        'Paid',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                kSizedBoxH4,
                                kSizedBoxH12,
                                RichText(
                                  text: TextSpan(
                                    text: 'Gross : ',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '\$${employees['gross_salary']}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.lightBlueColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            thickness: 1,
                            height: 15,
                            color: Colors.grey.shade300,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              payrollDetails(
                                  'Basic Salary: ', employees['basic_salary']),
                              payrollDetails('Tax: ', employees['tax']),
                            ],
                          ),
                          kSizedBoxH6,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              payrollDetails(
                                  'Allowance: ', employees['allowance']),
                              payrollDetails(
                                  'Deduction: ', employees['deduction']),
                            ],
                          ),
                          kSizedBoxH6,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              payrollDetails('Bonus: ', employees['bonus']),
                              payrollDetails(
                                  'Commission: ', employees['commission']),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget processButton(String text, Color color) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.5,
          color: color,
        ),
      ),
    );

Widget payrollDetails(text, details) => RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        children: [
          TextSpan(
            text: '\$ $details',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: CustomColors.lightBlueColor,
            ),
          )
        ],
      ),
    );
