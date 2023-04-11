import 'package:get/get.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/screens/split_payment/mpaisa.dart';

import '../../models/split_payment/mpaisa_response_model.dart';
import '../webview/custom_webview_page.dart';

class PaymentController extends GetxController {


  String getImagePath(int index) {
    if (index == 0) {
      return IconPath.windcavePng;
    } else if (index == 1) {
      return IconPath.mPesaPng;
    } else {
      return IconPath.myCashPng;
    }
  }



  // goToMPaisaPayment() async {
  //   Mpaisa mpaisa = Mpaisa();
  //   MPaisaPaymentModel mPaisaPaymentModel = await mpaisa.connectToMpaisa();
  //   if (mPaisaPaymentModel.destinationurl != null) {
  //     mpaisa.goToWebViewPage(mPaisaPaymentModel);
  //   }
  // }
}
