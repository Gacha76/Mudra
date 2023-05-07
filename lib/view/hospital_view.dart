import 'package:classico/utilities/widgets/hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:classico/utilities/widgets/app_bar_container.dart';
import 'package:classico/utilities/widgets/item_hospital_widget.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({super.key});

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  final List<HospitalModel> listHotel = [
    HospitalModel(
      hotelImage: 'assets/maps/sdm.jpg',
      hotelName: 'SDM College of medical sciences and Hospital',
      location: '9946348651',
      awayKilometer: '364 m',
      star: 4.5,
      numberOfReview: 3241,
      price: 143,
    ),
    HospitalModel(
      hotelImage: 'assets/maps/sdmd.png',
      hotelName: 'SDM college dental sciences and hospital',
      location: '9562169864',
      awayKilometer: '2.3 km',
      star: 4.2,
      numberOfReview: 3241,
      price: 234,
    ),
    HospitalModel(
      hotelImage: 'assets/maps/mul.png',
      hotelName: 'Mulamuttal Hospital',
      location: '9125243228',
      awayKilometer: '1.1 km',
      star: 3.8,
      numberOfReview: 1234,
      price: 132,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      implementTrailing: true,
      titleString: 'Hospitals',
      child: SingleChildScrollView(
        child: Column(
          children: listHotel
              .map(
                (e) => ItemHotelWidget(
                  hotelModel: e,
                  onTap: () {},
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
