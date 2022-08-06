import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_core/firebase_core.dart' as fbCore;
import 'package:flutter/material.dart';
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
import 'package:rewear/models/tailor.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/firestore.services.dart';
import 'package:rewear/services/general.services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInit {
  static final AppInit _singleton = AppInit._internal();
  factory AppInit() {
    return _singleton;
  }
  AppInit._internal();

  static const String GOOGLE_MAP_API =
      'AIzaSyAHTTUlO5TGGXIYOxIW0PjEk6iAFAUL8S0';
  static const String BASE_URL = 'https://asbrothers.ca';
  static const String TERMS_CONDITION_URL = 'https://asbrothers.ca/terms';
  static const String PRIVACY_POLICY_URL = 'https://asbrothers.ca/privacy';
  static const String googleMapStyle01 =
      '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"administrative.land_parcel","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]';

  fbCore.FirebaseApp? firebaseApp;

  bool isUserLoggedIn = false;
  User user = User();
  Tailor tailor = Tailor();
  Position? currentPosition;

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

  Future<void> updateLastLocation(
      {bool firestoreUpdate = false, bool isBackground = false}) async {
    final isServiceEnabled =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      if (!isBackground) {
        Get.dialog(const TurnOffLocationDialog(),
            useSafeArea: true,
            barrierColor: Colors.black87,
            transitionCurve: Curves.easeInOut);
      }
      return;
    }
    final check = await GeolocatorPlatform.instance.checkPermission();
    if (check == LocationPermission.whileInUse ||
        check == LocationPermission.always) {
      currentPosition = await GeolocatorPlatform.instance.getCurrentPosition();
      user.position =
          LatLng(currentPosition!.latitude, currentPosition!.longitude);

      // Geolocating
      final geolocatedModel =
          await GeneralServices().geoCoding(AppInit().user.position!);
      if (user.role == UserType.customer) user.address = geolocatedModel?.addr;
      user.city = geolocatedModel?.city;
      user.country = geolocatedModel?.country;

      if (firestoreUpdate) {
        await FirestoreServices().updateUserWithDocId(user.docId!, {
          'position':
              '${currentPosition!.latitude}, ${currentPosition!.longitude}',
          'updatedAt': DateTime.now()
        });
      }
    } else {
      await GeolocatorPlatform.instance.requestPermission();
    }
  }

  Future<void> updateUserData(
      {bool isLogin = true,
      UserType? role,
      String? fullname,
      User? currentUser,
      fbAuth.UserCredential? credential}) async {
    final token = await credential?.user?.getIdToken();
    final fcmToken = ''; // await FirebaseMessaging.instance.getToken();
    final user = currentUser ??
        User(
            uid: credential?.user?.uid,
            email: credential?.user?.email,
            fullname: fullname ?? credential?.user?.displayName,
            role: role,
            token: token,
            fcmToken: fcmToken);

    var dataForUpdate = {'token': token, 'fcmToken': fcmToken};

    if (isLogin) {
      // Login
    } else {
      // Sign up
      final docId = await FirestoreServices()
          .addUser(user.toJsonForFirestore(createdAt: true));
      user.docId = docId;
      dataForUpdate['docId'] = docId;
    }
    AppInit().user = user;
    await AppInit().user.saveToCacheAndLogin();
    await FirestoreServices()
        .updateUserWithDocId(AppInit().user.docId!, dataForUpdate);
  }

  Future<void> preInit() async {
    await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();
    firebaseApp = await fbCore.Firebase.initializeApp();

    // Check user is logged in or not
    user = User.fromCache();
    if (user.uid != null) {
      isUserLoggedIn = true;
    } else {
      isUserLoggedIn = false;
    }
  }

  void handleError(exception) {
    String title = '';
    String message = '';
    switch (exception.runtimeType) {
      case fbAuth.FirebaseException:
      case fbAuth.FirebaseAuthException:
        title =
            exception.code.toString().replaceAll('-', ' ').capitalizeFirst ??
                '';
        message = exception.message ?? '';
        break;
      case MyErrorException:
        title = exception.title;
        message = exception.message ?? '';
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
}
