import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/orderStatus.enum.dart';
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
      if (request!.orderStatus == OrderStatus.acceptedBySeller) {
        showBottomPriceButtons.value = true;
      } else {
        showBottomPriceButtons.value = false;
      }
      _getTailorProfile();
    } else {
      if (request!.orderStatus == OrderStatus.pending) {
        showBottomPriceButtons.value = true;
      } else {
        showBottomPriceButtons.value = false;
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
            orderStatus: OrderStatus.acceptedByBoth,
            sellerSeen: false,
            fcmToken: tailor.value?.fcmToken ?? '',
            req: request!);
        request!.orderStatus = OrderStatus.acceptedByBoth;
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
            orderStatus: OrderStatus.acceptedBySeller,
            price: double.parse(strPrice.value),
            customerSeen: false,
            fcmToken: tailor.value?.fcmToken ?? '',
            req: request!);
        request!.orderStatus = OrderStatus.acceptedBySeller;
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
            orderStatus: OrderStatus.rejectedByCustomer,
            cancelExcuse: '',
            sellerSeen: false,
            fcmToken: tailor.value?.fcmToken ?? '',
            req: request!);
        request!.orderStatus = OrderStatus.rejectedByCustomer;
        app.notifyUserBySocket(request!);
        updateRequestsLocally(reject: true);
      } else {
        // seller
        await services.updateRequestStatusBySeller(
            reqId: request!.id!,
            orderStatus: OrderStatus.rejectedBySeller,
            cancelExcuse: '',
            customerSeen: false,
            fcmToken: tailor.value?.fcmToken ?? '',
            req: request!);
        request!.orderStatus = OrderStatus.rejectedBySeller;
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
      if (!request!.customerSeen) {
        await services.updateRequestStatusBySeller(
          customerSeen: true,
          reqId: request!.id!,
          req: request!,
          fcmToken: tailor.value?.fcmToken ?? '',
        );
        app.notifyUserBySocket(request!);
        updateRequestsLocally(seen: true);
      }
    } else {
      if (!request!.sellerSeen) {
        await services.updateRequestStatusByCustomer(
          sellerSeen: true,
          reqId: request!.id!,
          req: request!,
          fcmToken: tailor.value?.fcmToken ?? '',
        );
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
        if (accept != null && accept) {
          app.requests[index].orderStatus = OrderStatus.acceptedBySeller;
        }
        if (reject != null && reject) {
          app.requests[index].orderStatus = OrderStatus.rejectedBySeller;
        }
        if (seen != null) {
          app.requests[index].sellerSeen = seen;
        }
        app.tailorsStreamController.sink.add(true);
      } else {
        // customer
        if (accept != null && accept) {
          app.requests[index].orderStatus = OrderStatus.acceptedBySeller;
        }
        if (reject != null && reject) {
          app.requests[index].orderStatus = OrderStatus.rejectedByCustomer;
        }
        if (seen != null) {
          app.requests[index].customerSeen = seen;
        }
        app.requestsStreamController.sink.add(true);
      }
    }
  }
}
