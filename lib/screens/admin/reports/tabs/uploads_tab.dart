import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/routes/app_routes.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import '../../../../core/constants/styles.dart';

class UploadsTabAdmin extends StatelessWidget {
  const UploadsTabAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Get.find<ReportsControllerAdmin>().chatGroupList.length,
      itemBuilder: (context, index) {
        var chatList = Get.find<ReportsControllerAdmin>().chatGroupList;
        return Obx(() => InkWell(
              onTap: () => Get.toNamed(Routes.uploadFilesPage),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.2, color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    chatList[index].name,
                    style: kTextStyleS18W600CBlack,
                  ),
                  subtitle: Text(chatList[index].id),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(chatList[index].image),
                  ),
                  trailing: Text(
                    chatList[index].branch,
                    style: kTextStyleS13W500Cgrey,
                  ),
                ),
              ),
            ));
      },
    );
  }
}
