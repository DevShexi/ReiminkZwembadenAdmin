import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    Key? key,
    required this.width,
    required this.height,
    this.radius,
  }) : super(key: key);
  final double width;
  final double height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(
          radius ?? 6.0,
        ),
      ),
      height: height,
      width: width,
    );
  }
}
