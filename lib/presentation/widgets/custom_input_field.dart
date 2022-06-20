import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.label,
    this.icon,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.errorText,
    this.focusNode,
    this.validator,
    required this.isObscure,
  }) : super(key: key);
  final String label;
  final IconData? icon;
  final String? hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final Widget? suffixIcon;
  final String? errorText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

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
        color: errorText == null
            ? AppColors.lightGrey
            : AppColors.errorLight.withOpacity(0.5),
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
                style: AppStyles.smallLabel.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          TextFormField(
            validator: validator,
            focusNode: focusNode,
            obscureText: isObscure,
            controller: controller,
            style: AppStyles.textField,
            decoration: InputDecoration(
              errorText: errorText,
              errorStyle: AppStyles.error,
              suffixIcon: suffixIcon,
              suffixIconConstraints:
                  const BoxConstraints.tightFor(width: 30, height: 30),
              isDense: true,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppStyles.hint,
            ),
          ),
        ],
      ),
    );
  }
}
