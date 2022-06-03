import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.button,
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 1,
          color: AppColors.primary,
        ),
        backgroundColor: Colors.white,
        primary: AppColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      ),
    );
  }
}
