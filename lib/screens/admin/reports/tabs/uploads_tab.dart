import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/routes/app_routes.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_admin.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import '../../../../core/constants/styles.dart';

class UploadsTabAdmin extends StatelessWidget {
  const UploadsTabAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: Get.find<DashboardControllerAdmin>().employeeList.value.employeeList?.length??0,
          itemBuilder: (context, index) {
            var chatList = Get.find<DashboardControllerAdmin>()
                .employeeList
                .value
                .employeeList;
            return InkWell(
                  onTap: () => Get.toNamed(Routes.uploadFilesPage),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                  border: Border.all(width: 1.2, color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    '${chatList?[index].firstName} ${chatList?[index].lastName}',
                    style: kTextStyleS18W600CBlack,
                  ),
                  subtitle: Text('#${chatList?[index].id.toString().padLeft(5,'0')}'),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(chatList?[index].image??''),
                  ),
                  trailing: Text(
                    chatList?[index].branch?.name??'',
                    style: kTextStyleS13W500Cgrey,
                  ),
                ),
              ),
            );
      },
    ));
  }
}
