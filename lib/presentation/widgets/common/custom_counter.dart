import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_loading_indicator.dart';

import '../../../common/resources/resources.dart';

class CustomCounter extends StatelessWidget {
  const CustomCounter({
    Key? key,
    required this.controller,
    required this.onDecrement,
    required this.onIncrement,
    required this.onChanged,
    required this.active,
    this.size,
  }) : super(key: key);
  final TextEditingController controller;
  final Function(String value) onChanged;
  final Function() onIncrement;
  final Function() onDecrement;
  final bool active;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCounterButton(
          action: onDecrement,
          icon: Icons.remove,
          disabled: !active,
          size: size,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            width: size != null ? size!.width * 1.24 : 35,
            height: size != null ? size!.height : 24,
            child: TextFormField(
              onChanged: onChanged,
              controller: controller,
              enableInteractiveSelection: false,
              cursorColor: AppColors.textGrey.withOpacity(0.5),
              // cursorHeight: 10,
              cursorWidth: 0.5,
              decoration: InputDecoration(
                filled: !active,
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: !active ? AppColors.grey : AppColors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: !active ? AppColors.grey : AppColors.blue,
                  ),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[1-9]'),
                ),
                // LengthLimitingTextInputFormatter(1),
              ],
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: const TextInputType.numberWithOptions(),
              onEditingComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
        ),
        CustomCounterButton(
          action: onIncrement,
          icon: Icons.add,
          disabled: !active,
          size: size,
        ),
      ],
    );
  }
}

class CustomCounterButton extends StatelessWidget {
  const CustomCounterButton({
    Key? key,
    required this.action,
    required this.icon,
    required this.disabled,
    this.size,
  }) : super(key: key);
  final IconData icon;
  final Function() action;
  final bool disabled;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      color: disabled ? AppColors.lightGrey : AppColors.lightBlue,
      elevation: 3.0,
      child: InkWell(
        splashColor: AppColors.primary.withOpacity(
          0.5,
        ),
        borderRadius: BorderRadius.circular(
          4.0,
        ),
        onTap: action,
        child: SizedBox(
          width: size != null ? size!.width : 24,
          height: size != null ? size!.height : 24,
          child: Icon(
            icon,
            color: disabled ? AppColors.grey : AppColors.primary,
            size: 16.0,
          ),
        ),
      ),
    );
  }
}

class CustomCounterButtonLoader extends StatelessWidget {
  const CustomCounterButtonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomLoadingIndicator(width: 24, height: 24, radius: 4.0);
  }
}

class CustomCounterLoader extends StatelessWidget {
  const CustomCounterLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        CustomLoadingIndicator(width: 24, height: 24, radius: 4.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: CustomLoadingIndicator(width: 35, height: 24, radius: 4.0),
        ),
        CustomLoadingIndicator(width: 24, height: 24, radius: 4.0),
      ],
    );
  }
}
