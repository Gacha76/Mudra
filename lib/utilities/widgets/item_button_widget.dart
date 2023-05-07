import 'package:flutter/material.dart';
import 'package:classico/constants/colors.dart';
import 'package:classico/constants/dimensions.dart';
import 'package:classico/constants/text_style.dart';

class ItemButtonWidget extends StatelessWidget {
  const ItemButtonWidget(
      {super.key, required this.title, this.ontap, this.color});

  final String title;
  final Function()? ontap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(kMediumPadding),
          gradient: Gradients.defaultGradientBackground,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: color == null
              ? TextStyles.defaultStyle.whiteTextColor.bold
              : TextStyles.defaultStyle.bold.copyWith(
                  color: Color.fromARGB(255, 6, 3, 29),
                ),
        ),
      ),
    );
  }
}
