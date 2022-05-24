import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/data/constants/colors/Colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color,
    this.borderColor,
  }) : super(key: key);
  final String label;
  final Function() onPressed;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 388,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: color ?? AppColors.blue,
                primary: borderColor ?? Colors.white,
                shape: borderColor != null
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          7,
                        ),
                        side: BorderSide(color: borderColor!, width: 1.0),
                      )
                    : null,
              ),
              onPressed: onPressed,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
