import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:paytym/models/split_payment/mpaisa_response_model.dart';
import 'package:paytym/network/end_points.dart';

import '../../../routes/app_routes.dart';
import '../../webview/custom_webview_page.dart';

class Mpaisa {
  String tID = '124';

  /// example get url: https://pay.mpaisa.vodafone.com.fj/API/?url=petty.ga&&tID=105&&amt=100&&cID=20191&&iDet=ddddd
  Future<MPaisaPaymentModel> connectToMpaisa() async {
    Map<String, dynamic> mPaisaParameters = {
      'url': kDomainUrl, // company domain name eg: petty.ga
      'tID': tID, // integer, should increment everytime
      'amt': '200', // amount in fiji
      // client id (obtained from client) we need to ask this client id in the mobile app
      'cID': '20191',
      'iDet': 'dddddd', //item description
    };

    var url = Uri.https(kMpaisaBaseUrl, '/API/', mPaisaParameters);

    var response = await http.get(url);
    print(response.body);
    MPaisaPaymentModel mPaisaPaymentModel =
        mPaisaPaymentModelFromJson(response.body);
    return mPaisaPaymentModel;

    //{
    //"destinationurl":"https:\/\/pay.mpaisa.vodafone.com.fj\/",
    //"requestID":20056,"response":101,
    //"token":"DCA9AE00A017CF6F6068A60AD4E36BD1",
    //"tokenv2":"0B3CE7A95C05EB9A6FEC1E9E11357309533ABAB77DBEB6617DE5EDF93C1830C3"
    //}
  }

  goToWebViewPage(MPaisaPaymentModel? mPaisaPaymentModel) {
    // url: 'https://pay.mpaisa.vodafone.com.fj/?url=petty.ga&&tID=106&&amt=100&&cID=20191&&iDet=ddddd&&rID=20045'
    String amount = '100';
    String cID = '20191';
    String itemDesc = 'ddddd';
    var url =
        '${mPaisaPaymentModel?.destinationurl?.replaceAll('\\', '')}?url=$kDomainUrl&&tID=$tID&&amt=$amount&&cID=$cID&&iDet=$itemDesc&&rID=${mPaisaPaymentModel?.requestId}';
    Get.toNamed(Routes.webview, arguments: url);
  }
}
