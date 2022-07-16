import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/common/utils/validators.dart';
import 'package:reimink_zwembaden_admin/data/models/client_pool.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/clients/pools/edit_pool_sensors_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class EditPoolScreen extends StatefulWidget {
  const EditPoolScreen({Key? key, required this.clientPool}) : super(key: key);
  final ClientPool clientPool;

  @override
  State<EditPoolScreen> createState() => _EditPoolScreenState();
}

class _EditPoolScreenState extends State<EditPoolScreen> {
  final TextEditingController _poolNameController = TextEditingController();
  final TextEditingController _poolTopicController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _poolNameController.text = widget.clientPool.poolName;
    _poolTopicController.text = widget.clientPool.poolTopic!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _poolNameController.text == widget.clientPool.poolName;
    _poolTopicController.text == widget.clientPool.poolTopic;
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.clientPool.clientName,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10.0),
                CustomInputField(
                  controller: _poolNameController,
                  validator: InputValidator.requiredFieldValidator,
                  label: Strings.poolName,
                  isObscure: false,
                  icon: Icons.pool,
                ),
                const SizedBox(height: 4.0),
                CustomInputField(
                  controller: _poolTopicController,
                  validator: InputValidator.requiredFieldValidator,
                  label: Strings.poolTopic,
                  isObscure: false,
                  icon: Icons.pool,
                ),
                const SizedBox(height: 4.0),
                const Spacer(),
                const SizedBox(
                  height: 10.0,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return PrimaryButton(
                      label: Strings.continueButton,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.clientPool.poolName = _poolNameController.text;
                          widget.clientPool.poolTopic =
                              _poolTopicController.text;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditPoolSensorsScreen(
                                  clientPool: widget.clientPool),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
