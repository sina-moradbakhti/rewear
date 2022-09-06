import 'package:rewear/config/app_init.dart';

class HttpServices {
  final String baseUrl = AppInit.BASE_URL;
  handleError(dynamic exc) => AppInit().handleError(exc);
}
