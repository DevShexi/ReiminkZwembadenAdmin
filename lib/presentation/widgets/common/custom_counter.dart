import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_loading_indicator.dart';

class CustomCounter extends StatelessWidget {
  const CustomCounter({
    Key? key,
    required this.onDecrement,
    required this.onIncrement,
    required this.value,
    required this.active,
    this.size,
  }) : super(key: key);
  final Function() onIncrement;
  final Function() onDecrement;
  final int value;
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
          child: Material(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            color: !active ? AppColors.lightGrey : AppColors.lightBlue,
            child: Container(
              width: size != null ? size!.width * 1.24 : 35,
              height: size != null ? size!.height : 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: value > 0
                    ? Text(
                        value.toString(),
                      )
                    : const Text(""),
              ),
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
