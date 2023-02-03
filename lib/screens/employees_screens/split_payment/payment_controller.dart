import 'package:get/get.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/screens/employees_screens/split_payment/mpaisa.dart';

import '../../../models/split_payment/mpaisa_response_model.dart';
import '../../webview/custom_webview_page.dart';

class PaymentController extends GetxController {
  final isWindcaveSelected = false.obs;
  final isMpesaSelected = false.obs;
  final isMyCashSelected = false.obs;

  String getImagePath(int index) {
    if (index == 0) {
      return IconPath.windcavePng;
    } else if (index == 1) {
      return IconPath.mPesaPng;
    } else {
      return IconPath.myCashPng;
    }
  }

  selectPaymentMethod(index) {
    if (index == 0) {
      isWindcaveSelected.value = true;
    }
    if (index == 1) {
      isMpesaSelected.value = true;
    }
    if (index == 2) {
      isMyCashSelected.value = true;
    }
  }

  goToMPaisaPayment() async {
    Mpaisa mpaisa = Mpaisa();
    MPaisaPaymentModel mPaisaPaymentModel = await mpaisa.connectToMpaisa();
    if (mPaisaPaymentModel.destinationurl != null) {
      mpaisa.goToWebViewPage(mPaisaPaymentModel);
    }
  }
}
