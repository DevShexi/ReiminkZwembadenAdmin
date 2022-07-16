import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/common/utils/validators.dart';
import 'package:reimink_zwembaden_admin/data/models/client_pool.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/client_pool_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_elevated_button.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_outlined_button.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';

class DuplicatePoolInputDialog extends ConsumerStatefulWidget {
  const DuplicatePoolInputDialog({Key? key, required this.clientPool})
      : super(key: key);
  final ClientPool clientPool;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DuplicatePoolInputDialogState();
}

class _DuplicatePoolInputDialogState
    extends ConsumerState<DuplicatePoolInputDialog> {
  final TextEditingController _poolNameController = TextEditingController();
  final TextEditingController _poolTopicController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onDuplicate() {
    if (_formKey.currentState!.validate()) {
      if (_poolNameController.text == widget.clientPool.poolName ||
          _poolTopicController.text == widget.clientPool.poolTopic) {
        ref
            .watch(clientPoolNotifierProvider.notifier)
            .throwError(errorMessage: Strings.duplicatedPoolNameErrorMessage);
      } else {
        ref.watch(clientPoolNotifierProvider.notifier).addPool(
              clientName: widget.clientPool.clientName,
              clientId: widget.clientPool.clientId,
              poolName: _poolNameController.text,
              poolTopic: _poolTopicController.text,
              poolSensors: widget.clientPool.poolSensors,
            );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.duplicatePool),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInputField(
              controller: _poolNameController,
              validator: InputValidator.requiredFieldValidator,
              label: Strings.poolName,
              isObscure: false,
              icon: Icons.pool,
            ),
            const SizedBox(height: 10),
            CustomInputField(
              controller: _poolTopicController,
              validator: InputValidator.requiredFieldValidator,
              label: Strings.poolTopic,
              isObscure: false,
              icon: Icons.pool,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    label: Strings.duplicate,
                    onPressed: onDuplicate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
