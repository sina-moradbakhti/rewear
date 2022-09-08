import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/get_tailors_nearby.dart';
import 'package:rewear/services/init.dart';

class LaunchBloc extends GetxController {
  final app = AppInit();
  final tailorsServices = TailorsServices();
  final initService = InitService();

  var loadingStatus = true.obs;

  @override
  void onInit() {
    _init(false);
    super.onInit();
  }

  void reInit() => _init(true);

  void _init(bool reInit) async {
    if (reInit) {
      loadingStatus.value = true;
    }
    await app.preInit();
    await Future.delayed(const Duration(seconds: 2));
    if (app.isUserLoggedIn) {
      final initstatus = await initService.call();
      if (!initstatus) {
        loadingStatus.value = false;
        return;
      }

      if (app.user.role == UserType.customer) {
        await tailorsServices.getTailorsNearby(); // listen for new tailors
      }

      app.initSocketClient();

      Get.offNamed(MyRoutes.home);
    } else {
      Get.offNamed(MyRoutes.welcome);
    }
  }
}
