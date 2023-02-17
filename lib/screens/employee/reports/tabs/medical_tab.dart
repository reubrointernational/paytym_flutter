import 'package:flutter/material.dart';

import '../../../../core/constants/strings.dart';

class MedicalTab extends StatelessWidget {
  const MedicalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final medicalData = medicalDetails[index];
            return ListTile(
              title: Text(
                medicalData['title'],
                style: const TextStyle(fontSize: 13),
              ),
              subtitle: Text(medicalData['subtitle']),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
          itemCount: medicalDetails.length),
    );
  }
}
