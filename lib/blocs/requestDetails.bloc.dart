import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/models/tailor.dart';
import 'package:rewear/services/firestore.services.dart';

class RequestDetailsBloc extends GetxController {
  final app = AppInit();
  Request? request;
  Rx<Tailor?> tailor = Tailor().obs;

  @override
  void onInit() {
    request = Get.arguments;
    _getTailorProfile();
    _seen();
    super.onInit();
  }

  void _getTailorProfile() async {
    final user = await FirestoreServices().getUser(request!.sellerId ?? '');
    tailor.value = Tailor.fromJson(user.data);
  }

  void accept() async {}
  void cancel() async {}

  void _seen() {
    if (!request!.seen) {
      FirestoreServices().updateRequests({'seen': true}, request!.docId ?? '');
    }
  }
}
