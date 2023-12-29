import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';

class CustomCardDetails extends StatelessWidget {
   const CustomCardDetails({super.key});
  //var ac=Get.find<DashboardControllerAdmin>().fetchDashboardDetails();

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
      child: FutureBuilder(

        future: Get.find<DashboardControllerAdmin>().fetchDashboardDetails(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 2,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final details =
                    Get.find<DashboardControllerAdmin>().getCardDetails(index);
                return InkWell(
                  onTap: () => Get.find<DashboardControllerAdmin>()
                      .seeDetailsPage(index),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1, color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                                radius: 18,
                                backgroundColor: details['color'],
                                child: Image.asset(
                                  details['icon'],
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                )),
                            Text(
                              details['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: details['color'],
                              ),
                            ),
                            Text(
                              details['count'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                  fontSize: 25),
                            ),
                          ]),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
