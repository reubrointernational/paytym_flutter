import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';

class MyFilesTab extends StatelessWidget {
  const MyFilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: const ListTile(
            title: Text('Payslip'),
            trailing: CircleAvatar(
              backgroundColor: CustomColors.blueCardColor,
              child: Icon(Icons.download_outlined),
            ),
          ),
        );
      },
    );
  }
}
