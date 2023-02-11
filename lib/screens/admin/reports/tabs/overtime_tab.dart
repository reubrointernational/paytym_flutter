import 'package:flutter/material.dart';
import 'package:paytym/core/constants/widgets.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../widgets/payment_history.dart';

class OvertimeTabAdmin extends StatelessWidget {
  const OvertimeTabAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: earningsLists.length,
      itemBuilder: (context, index) {
        final employees = earningsLists[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: GestureDetector(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              DetailsRow(
                                title: "Start Date: ",
                                value: "10-02-2023",
                              ),
                              DetailsRow(
                                title: "Start Time: ",
                                value: "07:30 PM",
                              ),
                              kSizedBoxH3,
                              DetailsRow(
                                title: "End Date: ",
                                value: "10-02-2023",
                              ),
                              DetailsRow(
                                title: "End Time: ",
                                value: "07:30 PM",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Reason: ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Overtime alloted by Akhil',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      processButton('Decline', CustomColors.redColor),
                      kSizedBoxW10,
                      processButton('Edit', CustomColors.blueCardColor),
                      kSizedBoxW10,
                      processButton('Approve', CustomColors.greenColor),
                    ],
                  ),
                  kSizedBoxH10,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DetailsRow extends StatelessWidget {
  final String title;
  final String value;
  const DetailsRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
