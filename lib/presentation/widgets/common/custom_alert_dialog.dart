import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_elevated_button.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_outlined_button.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.label,
    required this.promptMessage,
    required this.actionLabel,
    required this.action,
  }) : super(key: key);
  final String label;
  final String promptMessage;
  final String actionLabel;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          7.0,
        ),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/svg/alert.svg"),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              promptMessage,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    label: Strings.cancel,
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: CustomElevatedButton(
                    label: actionLabel,
                    onPressed: action,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
