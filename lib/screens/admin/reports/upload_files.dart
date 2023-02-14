import 'package:flutter/material.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/widgets/file_upload_widget.dart';

import '../widgets/custom_admin_scaffold.dart';

class UploadFilesPage extends StatelessWidget {
  const UploadFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAdminScaffold(
      title: 'Upload Files',
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            kSizedBoxH10,
            FileUploadWidget(
              title: 'File Name',
              subtitle: 'Upload files upto 4MB',
              onTap: () {},
            ),
            kSizedBoxH10,
            SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
