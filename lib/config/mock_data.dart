import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/models/tailor.dart';

class MockData {
  static final MockData _singleton = MockData._internal();
  factory MockData() {
    return _singleton;
  }
  MockData._internal();

  List<Tailor> tailories = [
    Tailor(
        position: LatLng(45.5616284, -73.6056387),
        address: '7734 Bd Saint-Michel, Montréal, QC H2A 3A5, Canada',
        city: 'QC, Montréal',
        country: 'CA',
        email: 'lynn@google.com',
        fullname: 'Lynn — Tailor',
        image:
            'https://pr1.nicelocal.ca/qpMl5En9i9Z8BBUeOIpcjw/587x440,q85/4px-BW84_n0QJGVPszge3NRBsKw-2VcOifrJIjPYFYkOtaCZxxXQ2QYGKPyr9phEd2hf2KdrWWhmco4x-UwPq9Z05LRz1uf85kBf0Qhk-gVUWUuWK--t5Q',
        phone: '+11234567',
        rate: 4,
        uid: '1'),
    Tailor(
        position: LatLng(45.5619213, -73.6073339),
        address: '751 Boul Crémazie E, Montréal, QC H2A, Canada',
        city: 'QC, Montréal',
        country: 'CA',
        email: 'lynn@google.com',
        fullname: 'Tailor Test 1',
        image:
            'https://i.pinimg.com/originals/26/85/6d/26856d80372f352a4ac6ff99771e2d33.jpg',
        phone: '+11234567',
        rate: 3,
        uid: '2'),
    Tailor(
        position: LatLng(45.5605547, -73.6058069),
        address: '7593 9e Avenue, Montréal, QC H2A 3C2, Canada',
        city: 'QC, Montréal',
        country: 'CA',
        email: 'lynn@google.com',
        fullname: 'Tailory Test 2',
        image:
            'https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/75/59/91/755991c2-c465-093d-d205-c4deccd6caab/source/512x512bb.jpg',
        phone: '+11234567',
        rate: 5,
        uid: '3'),
    Tailor(
        position: LatLng(43.7081565, -79.3445129),
        address: '90 Thorncliffe Park Dr, East York, ON M4H 1N5, Canada',
        city: 'ON, East York',
        country: 'CA',
        email: 'lynn@google.com',
        fullname: 'Tailory Toronto',
        image:
            'https://dancingwithher.com/wp-content/uploads/2022/05/The-Tailory-New-York-USA-lesbian-gay-non-binary-queer-wedding-elopement-attire-suits-tuxedos-outfits-Dancing-With-Her-magazine-online-directory-11.jpg',
        phone: '+11234567',
        rate: 2,
        uid: '4'),
    Tailor(
        position: LatLng(44.0599831, -79.4582296),
        address: '499 Davis Dr, Newmarket, ON L3Y 6P5, Canada',
        city: 'ON, Newmarket',
        country: 'CA',
        email: 'lynn@google.com',
        fullname: 'Taylor Funeral Home',
        image:
            'https://nowtoronto.com/wp-content/uploads/2020/05/Garrison_tailoring-980x618.jpg',
        phone: '+11234567',
        rate: 0,
        uid: '5')
  ];
}
