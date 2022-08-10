import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/models/tailor.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/firestore.services.dart';

class RequestDetailsBloc extends GetxController {
  final app = AppInit();
  Request? request;
  Rx<Tailor?> tailor = Tailor().obs;
  Rx<User?> customer = User().obs;
  RxBool cancelLoading = false.obs;
  RxBool acceptLoading = false.obs;
  var showBottomPriceButtons = false.obs;
  Rx<String> strPrice = ''.obs;

  @override
  void onInit() {
    request = Get.arguments;
    if (app.user.role == UserType.customer) {
      if (request!.acceptedBySeller &&
          (!request!.acceptedByUser && !request!.canceledByUser)) {
        showBottomPriceButtons.value = true;
      }
      _getTailorProfile();
    } else {
      if (!request!.acceptedBySeller &&
          !request!.canceledBySeller &&
          !request!.canceledByUser) {
        showBottomPriceButtons.value = true;
      }
      _getCustomerProfile();
    }
    _seen();
    super.onInit();
  }

  void _getTailorProfile() async {
    final user = await FirestoreServices().getUser(request!.sellerId ?? '');
    tailor.value = Tailor.fromJson(user.data);
  }

  void _getCustomerProfile() async {
    final user = await FirestoreServices().getUser(request!.customerId);
    customer.value = User.fromJson(user.data);
  }

  void accept() async {
    try {
      acceptLoading.value = true;

      if (app.user.role == UserType.customer) {
        // customer
        await FirestoreServices().updateRequests(
            {'acceptedByUser': true, 'tailorSeen': false},
            request!.docId ?? '');
        request!.acceptedByUser = true;
      } else {
        // seller

        if (strPrice.value.isEmpty) {
          acceptLoading.value = false;
          app.handleError(MyErrorException(
              title: 'Price',
              message: 'You have to estimate a price for this order!'));
          return;
        }

        await FirestoreServices().updateRequests({
          'acceptedBySeller': true,
          'price': double.parse(strPrice.value),
          'seen': false
        }, request!.docId ?? '');
        request!.acceptedBySeller = true;
      }

      acceptLoading.value = false;
      showBottomPriceButtons.value = false;
    } catch (er) {
      acceptLoading.value = false;
    }
  }

  void cancel() async {
    try {
      cancelLoading.value = true;

      if (app.user.role == UserType.customer) {
        // customer
        await FirestoreServices().updateRequests(
            {'canceledByUser': true, 'cancelExcuse': '', 'tailorSeen': false},
            request!.docId ?? '');
        request!.canceledByUser = true;
      } else {
        // seller
        await FirestoreServices().updateRequests(
            {'canceledBySeller': true, 'cancelExcuse': '', 'seen': false},
            request!.docId ?? '');
        request!.canceledBySeller = true;
      }

      cancelLoading.value = false;
      showBottomPriceButtons.value = false;
    } catch (er) {
      cancelLoading.value = false;
    }
  }

  void _seen() {
    if (app.user.role == UserType.customer) {
      if (!request!.seen) {
        FirestoreServices()
            .updateRequests({'seen': true}, request!.docId ?? '');
      }
    } else {
      if (!request!.tailorSeen) {
        FirestoreServices()
            .updateRequests({'tailorSeen': true}, request!.docId ?? '');
      }
    }
  }
}
