
import '../core/dialog_helper.dart';
import 'network_exceptions.dart';

class BaseController {
  void handleError(error) {
    hideLoading();
    String errorMessage = error.message ?? '';
    if (error is BadRequestException) {
      DialogHelper.showToast(desc: errorMessage);
    } else if (error is FetchDataException) {
      DialogHelper.showErrorDialog(desc: errorMessage);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorDialog(
        desc: 'It is taking long to respond',
      );
    }
  }

  showLoading([String message = '']) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}
