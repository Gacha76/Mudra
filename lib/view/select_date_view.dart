import 'package:flutter/material.dart';
import 'package:classico/constants/colors.dart';
import 'package:classico/constants/dimensions.dart';
import 'package:classico/utilities/widgets/app_bar_container.dart';
import 'package:classico/utilities/widgets/item_button_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: must_be_immutable
class SelectDateScreen extends StatelessWidget {
  SelectDateScreen({super.key});

  DateTime? rangeStartDate;

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        titleString: "Select date",
        paddingContent: EdgeInsets.all(kMediumPadding),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icon/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: kMediumPadding),
              SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                monthViewSettings:
                    DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                selectionColor: ColorPalette.yellowColor,
                startRangeSelectionColor: ColorPalette.yellowColor,
                todayHighlightColor: ColorPalette.yellowColor,
                toggleDaySelection: true,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is PickerDateRange) {
                    rangeStartDate = args.value.startDate;
                  }
                },
              ),
              ItemButtonWidget(
                title: "Select",
                ontap: () {
                  Navigator.of(context).pop([rangeStartDate]);
                },
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              ItemButtonWidget(
                title: "Cancel",
                color: ColorPalette.yellowColor.withOpacity(0.1),
                ontap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ));
  }
}
