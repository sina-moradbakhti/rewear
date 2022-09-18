import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/modals/location.modal.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/models/neckStyle.model.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/models/tailor.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/init.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppInit {
  static final AppInit _singleton = AppInit._internal();
  factory AppInit() {
    return _singleton;
  }
  AppInit._internal();

  IO.Socket? socket;

  static const String GOOGLE_MAP_API =
      'AIzaSyAHTTUlO5TGGXIYOxIW0PjEk6iAFAUL8S0';
  static const String BASE_URL =
      'https://rewear.asbrothers.ca'; // https://rewear.asbrothers.ca | http://localhost:4933
  static const String TERMS_CONDITION_URL = 'https://asbrothers.ca/terms';
  static const String PRIVACY_POLICY_URL = 'https://asbrothers.ca/privacy';
  static const String CONTACT_US = 'https://asbrothers.ca/#contact';
  static const String googleMapStyle01 =
      '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"administrative.land_parcel","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]';

  bool isUserLoggedIn = false;
  User user = User();
  Position? currentPosition;
  List<Request> requests = [];
  List<Tailor> tailors = [];

  final requestsStreamController = PublishSubject<bool>();
  Stream<bool> get requestsStream => requestsStreamController.stream;

  final tailorsStreamController = PublishSubject<bool>();
  Stream<bool> get tailorsStream => tailorsStreamController.stream;

  final List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.black,
    Colors.brown,
    Colors.white,
    Colors.grey
  ];

  final List<String> materials = [
    'Cotton',
    'Cellulosic fibres/viscose',
    'Wool',
    'Silk',
    'Leather',
    'Bast fibres',
    'Experimental fabrics',
    'Notions and hardware'
  ];
  final List<NeckStyleModel> neckStyles = [
    NeckStyleModel(
        clickedImage: MyImages.tShirt01,
        image: MyImages.tShirt01Grey,
        style: NeckStyle.style0),
    NeckStyleModel(
        clickedImage: MyImages.tShirt02,
        image: MyImages.tShirt02Grey,
        style: NeckStyle.style1),
    NeckStyleModel(
        clickedImage: MyImages.tShirt03,
        image: MyImages.tShirt03Grey,
        style: NeckStyle.style2),
    NeckStyleModel(
        clickedImage: MyImages.tShirt04,
        image: MyImages.tShirt04Grey,
        style: NeckStyle.style3)
  ];

  Future<bool> checkLocationPermission() async {
    final isServiceEnabled =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      Get.dialog(const TurnOffLocationDialog(),
          useSafeArea: true,
          barrierColor: Colors.black87,
          transitionCurve: Curves.easeInOut);
      return false;
    }

    final check = await GeolocatorPlatform.instance.checkPermission();
    if (check == LocationPermission.whileInUse ||
        check == LocationPermission.always) {
      return true;
    } else {
      final checkAgain = await GeolocatorPlatform.instance.requestPermission();
      return (checkAgain == LocationPermission.always ||
          checkAgain == LocationPermission.whileInUse);
    }
  }

  Future<bool> updateLastLocation({bool isBackground = false}) async {
    final isServiceEnabled =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      if (!isBackground) {
        Get.dialog(const TurnOffLocationDialog(),
            useSafeArea: true,
            barrierColor: Colors.black87,
            transitionCurve: Curves.easeInOut);
      }
      return false;
    }
    final check = await GeolocatorPlatform.instance.checkPermission();
    if (check == LocationPermission.whileInUse ||
        check == LocationPermission.always) {
      currentPosition = await GeolocatorPlatform.instance.getCurrentPosition();
      user.position =
          LatLng(currentPosition!.latitude, currentPosition!.longitude);
      return true;
      // Geolocating
      // final geolocatedModel =
      //     await GeneralServices().geoCoding(AppInit().user.position!);
      // if (user.role == UserType.customer) user.address = geolocatedModel?.addr;
      // user.city = geolocatedModel?.city;
      // user.country = geolocatedModel?.country;
    } else {
      final checkAgain = await GeolocatorPlatform.instance.requestPermission();
      final status = (checkAgain == LocationPermission.always ||
          checkAgain == LocationPermission.whileInUse);
      if (status) {
        currentPosition =
            await GeolocatorPlatform.instance.getCurrentPosition();
        user.position =
            LatLng(currentPosition!.latitude, currentPosition!.longitude);
      }
      return status;
    }
  }

  Future<void> initLibs() async {
    await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((event) {
      debugPrint('::::::::::: FOREGROUND NOTIFICATION :::::::::::');
      debugPrint(event.notification?.title);
      debugPrint(event.notification?.body);
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      debugPrint('::::::::::: BACKGROUND NOTIFICATION :::::::::::');
      debugPrint(message.notification?.title);
      debugPrint(message.notification?.body);
    });
    FlutterAppBadger.removeBadge();
  }

  Future<void> preInit() async {
    // Check user is logged in or not
    user = User.fromCache();
    if (user.id != null) {
      isUserLoggedIn = true;
    } else {
      isUserLoggedIn = false;
    }
  }

  void handleError(exception) {
    String title = '';
    String message = '';
    switch (exception.runtimeType) {
      // case fbAuth.FirebaseException:
      // case fbAuth.FirebaseAuthException:
      //   title =
      //       exception.code.toString().replaceAll('-', ' ').capitalizeFirst ??
      //           '';
      //   message = exception.message ?? '';
      //   break;
      case MyErrorException:
        title = exception.title;
        message = exception.message ?? '';
        break;
      default:
        title = 'Error';
        message = exception.toString();
        break;
    }

    Get.snackbar(title, message,
        backgroundColor: MyColors.orange,
        colorText: MyColors.white,
        titleText: Text(
          title,
          style: Get.theme.textTheme.bodyText1!
              .copyWith(color: MyColors.white, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          message,
          style: Get.theme.textTheme.bodyText1!
              .copyWith(color: MyColors.white, fontWeight: FontWeight.normal),
        ));
  }

  Future<void> openLink(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void initSocketClient() {
    AppInit().socket = IO.io(
        '$BASE_URL?token=${user.token}',
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .enableForceNew()
            .build());

    AppInit().socket?.onConnect((data) => print('Connected'));
    AppInit().socket?.onDisconnect((data) => print('Disconnected'));
    AppInit().socket?.onError((err) => print('Socket Error $err'));
    AppInit().socket?.onConnectError((err) => print('onConnectError $err'));
    AppInit().socket?.onConnectTimeout((err) => print('onConnectTimeout $err'));
    AppInit().socket?.on('onUpdatedRequest', (data) => _onMessageHandler(data));

    AppInit().socket?.connect();
  } // end socket client initialization

  _onMessageHandler(Map<String, dynamic> json) async {
    // final reqId = json['data']['reqId'];
    final initService = InitService();
    await initService.call();
    final tailor = user.role == UserType.seller;
    if (tailor) {
      tailorsStreamController.sink.add(true);
    } else {
      requestsStreamController.sink.add(true);
    }
  }

  void notifyUserBySocket(Request request) {
    final tailor = user.role == UserType.seller;
    AppInit().socket?.emit('update-request', {
      'to': !tailor ? request.seller!.id! : request.customer.id,
      'data': {'reqId': request.id!}
    });
  }
}
