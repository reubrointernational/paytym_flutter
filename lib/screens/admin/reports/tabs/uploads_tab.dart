import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/network/end_points.dart';
import 'package:paytym/routes/app_routes.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/styles.dart';
import '../../../../models/employee_list_model.dart';
import '../reports_controller.dart';

class UploadsTabAdmin extends StatelessWidget {
  const UploadsTabAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<DashboardControllerAdmin>().clearFilter());
    return Obx(() {
      List<EmployeeList>? chatList =
          Get.find<DashboardControllerAdmin>().getFilteredEmployeeList();
      return ListView.builder(
        itemCount: chatList?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.find<ReportsControllerAdmin>().selectedEmployeeId =
                  chatList?[index].id;
              Get.toNamed(Routes.uploadFilesPage);
            },
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
                subtitle:
                    Text('#${chatList?[index].id.toString().padLeft(5, '0')}'),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                      '$kStorageUrl${chatList?[index].image ?? ''}'),
                ),
                trailing: Text(
                  chatList?[index].branch?.name ?? '',
                  style: kTextStyleS13W500Cgrey,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
