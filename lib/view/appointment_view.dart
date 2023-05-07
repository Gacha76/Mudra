import 'package:classico/view/hospital_view.dart';
import 'package:flutter/material.dart';
import 'package:classico/constants/dimensions.dart';
import 'package:classico/view/select_date_view.dart';
import 'package:classico/utilities/widgets/app_bar_container.dart';
import 'package:classico/utilities/widgets/item_button_widget.dart';
import 'package:classico/extensions/booking/date_ext.dart';
import 'package:classico/utilities/widgets/item_options_booking.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/routes.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key, this.destination});

  final String? destination;

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String? selectdate;
  String? guestAndRoom;

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        titleString: 'Appointment Booking',
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icon/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: kMediumPadding * 2,
                ),
                ItemOptionsBookingWidget(
                  title: 'Location',
                  value: widget.destination ?? 'Hubli',
                  icon: const Icon(FontAwesomeIcons.locationPin),
                  onTap: () {},
                ),
                ItemOptionsBookingWidget(
                  title: 'Select Date',
                  value: selectdate ?? 'Select date',
                  icon: const Icon(FontAwesomeIcons.calendar),
                  onTap: () async {
                    final result =
                        await Navigator.of(context).pushNamed(selectDate);
                    if (result is List<DateTime?>) {
                      setState(() {
                        selectdate = '${result[0]?.getStartDate}';
                      });
                    }
                  },
                ),
                ItemButtonWidget(
                  title: 'Search',
                  ontap: () {
                    Navigator.of(context).pushNamed(hospitalScreen);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
