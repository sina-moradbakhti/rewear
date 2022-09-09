import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/models/tailor.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/requests.dart';

class RequestDetailsBloc extends GetxController {
  final app = AppInit();
  Request? request;
  Rx<Tailor?> tailor = Tailor().obs;
  Rx<User?> customer = User().obs;
  RxBool cancelLoading = false.obs;
  RxBool acceptLoading = false.obs;
  var showBottomPriceButtons = false.obs;
  Rx<String> strPrice = ''.obs;

  final services = RequestsServices();

  @override
  void onInit() {
    _init(true);
    if (app.user.role == UserType.seller) {
      app.tailorsStream.listen((event) {
        request =
            app.requests.firstWhere((element) => element.id == request!.id);
        _init(false);
      });
    } else {
      app.requestsStream.listen((event) {
        request =
            app.requests.firstWhere((element) => element.id == request!.id);
        _init(false);
      });
    }
    super.onInit();
  }

  void _init(bool firstTime) async {
    if (firstTime) request = Get.arguments;
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
  }

  void _getTailorProfile() async {
    tailor.value = Tailor.fromJson(request!.seller!.toJson());
  }

  void _getCustomerProfile() async {
    customer.value = User.fromJson(request!.customer.toJson());
  }

  void accept() async {
    try {
      acceptLoading.value = true;

      if (app.user.role == UserType.customer) {
        // customer
        await services.updateRequestStatusByCustomer(
            reqId: request!.id!,
            acceptByUser: true,
            sellerSeen: false,
            req: request!);
        request!.acceptedByUser = true;
        app.notifyUserBySocket(request!);
        updateRequestsLocally(accept: true);
      } else {
        // seller

        if (strPrice.value.isEmpty) {
          acceptLoading.value = false;
          app.handleError(MyErrorException(
              title: 'Price',
              message: 'You have to estimate a price for this order!'));
          return;
        }

        await services.updateRequestStatusBySeller(
            reqId: request!.id!,
            acceptBySeller: true,
            price: double.parse(strPrice.value),
            customerSeen: false,
            req: request!);
        request!.acceptedBySeller = true;
        app.notifyUserBySocket(request!);
        updateRequestsLocally(accept: true);
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
        await services.updateRequestStatusByCustomer(
            reqId: request!.id!,
            cancelByCustomer: true,
            cancelByCustomerExcuse: '',
            sellerSeen: false,
            req: request!);
        request!.canceledByUser = true;
        app.notifyUserBySocket(request!);
        updateRequestsLocally(reject: true);
      } else {
        // seller
        await services.updateRequestStatusBySeller(
            reqId: request!.id!,
            cancelBySeller: true,
            cancelBySellerExcuse: '',
            customerSeen: false,
            req: request!);
        request!.canceledBySeller = true;
        app.notifyUserBySocket(request!);
        updateRequestsLocally(reject: true);
      }

      cancelLoading.value = false;
      showBottomPriceButtons.value = false;
    } catch (er) {
      cancelLoading.value = false;
    }
  }

  void _seen() async {
    if (app.user.role == UserType.customer) {
      if (!request!.seen) {
        await services.updateRequestStatusBySeller(
            customerSeen: true, reqId: request!.id!, req: request!);
        app.notifyUserBySocket(request!);
        updateRequestsLocally(seen: true);
      }
    } else {
      if (!request!.tailorSeen) {
        await services.updateRequestStatusByCustomer(
            sellerSeen: true, reqId: request!.id!, req: request!);
        app.notifyUserBySocket(request!);
        updateRequestsLocally(seen: true);
      }
    }
  }

  void updateRequestsLocally({bool? accept, bool? reject, bool? seen}) {
    final index =
        app.requests.indexWhere((element) => element.id == request!.id);
    if (index >= 0) {
      if (app.user.role == UserType.seller) {
        // tailor
        if (accept != null) {
          app.requests[index].acceptedBySeller = accept;
        }
        if (reject != null) {
          app.requests[index].canceledBySeller = reject;
        }
        if (seen != null) {
          app.requests[index].tailorSeen = seen;
        }
        app.tailorsStreamController.sink.add(true);
      } else {
        // customer
        if (accept != null) {
          app.requests[index].acceptedByUser = accept;
        }
        if (reject != null) {
          app.requests[index].canceledByUser = reject;
        }
        if (seen != null) {
          app.requests[index].seen = seen;
        }
        app.requestsStreamController.sink.add(true);
      }
    }
  }
}
