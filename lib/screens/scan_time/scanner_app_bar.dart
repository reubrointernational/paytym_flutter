import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScannerAppBar extends StatelessWidget {
  const ScannerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/svg/menu.svg',
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                "Report",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            'assets/svg/settings.svg',
            width: 23,
            height: 23,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
