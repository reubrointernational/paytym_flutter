import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/dialog_helper.dart';

import '../../../core/download_path.dart';
import '../../../models/employee_list_model.dart';

class CsvDownloader {
  CsvDownloader();
  downloadCsv(List<EmployeeList> employeeList) async {
    List<String> title =
        List.generate(9, (index) => index == 0 ? 'PAYROLL' : '');
    List<String> headings = [
      'Name',
      'Employee ID',
      'Gross Salary',
      'Basic Salary',
      'Tax',
      'Allowance',
      'Deduction',
      'Bonus',
      'Commission'
    ];
    List<List<String>> payroll = [];
    payroll.add(title);
    payroll.add(headings);

    for (var e in employeeList) {
      payroll.add([
        '${e.firstName} ${e.lastName}',
        e.id.toString(),
        e.payroll?.grossSalary??'',
        e.payroll?.baseSalary??'',
        e.payroll?.totalTax??'',
        e.payroll?.totalAllowance??'',
        e.payroll?.totalDeduction??'',
        e.payroll?.totalBonus??'',
        e.payroll?.totalCommission??'',
      ]);
    }
    String csv = const ListToCsvConverter().convert(payroll);
    String? appDocPath = await DownloadPath().getDownloadPath();
    DateTime dateTime = DateTime.now();
    final date = DateFormat('dd_MM_yyyy_H_m_s').format(dateTime);
    File f = File("$appDocPath/payroll_$date.csv");
    f.writeAsString(csv);
    DialogHelper.showToast(desc: 'File downloaded');
  }
}
