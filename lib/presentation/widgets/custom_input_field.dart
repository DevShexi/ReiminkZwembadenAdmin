import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/data/constants/colors/Colors.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.label,
    this.icon,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.errorText,
    required this.isObscure,
  }) : super(key: key);
  final String label;
  final IconData? icon;
  final String? hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final Widget? suffixIcon;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388,
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: errorText == null ? AppColors.lightBlue : AppColors.errorLight,
        border: Border.all(
          color: errorText == null ? AppColors.lightBlue : AppColors.error,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 15,
                color: AppColors.blue,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          TextFormField(
            obscureText: isObscure,
            controller: controller,
            decoration: InputDecoration(
              errorText: errorText,
              suffixIcon: suffixIcon,
              suffixIconConstraints:
                  const BoxConstraints.tightFor(width: 30, height: 30),
              isDense: true,
              border: InputBorder.none,
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
