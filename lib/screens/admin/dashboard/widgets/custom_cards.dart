import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';

class CustomCardDetails extends StatelessWidget {
  final List<Map> details;
  const CustomCardDetails({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        FadeEffect(
          delay: Duration(milliseconds: 200),
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        ),
      ],
      child: SizedBox(
        height: h * 0.35,
        //color: Colors.yellow,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 3 / 2),
            itemCount: details.length,
            itemBuilder: (context, index) {
              final hr = details[index];
              return InkWell(
                onTap: () =>
                    Get.find<DashboardControllerAdmin>().seeDetailsPage(index),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1, color: Colors.grey.shade300)),
                  child: Container(
                    width: w,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                              radius: 18,
                              backgroundColor: hr['color'],
                              child: Image.asset(
                                hr['icon'],
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                              )),
                          Text(
                            hr['title'],
                            style: TextStyle(
                              color: hr['color'],
                            ),
                          ),
                          Text(
                            hr['count'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                                fontSize: 25),
                          ),
                        ]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
