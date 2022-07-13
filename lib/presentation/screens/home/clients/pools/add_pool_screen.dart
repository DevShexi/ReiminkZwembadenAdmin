import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/common/utils/validators.dart';
import 'package:reimink_zwembaden_admin/data/models/pools_listing_screen_args.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/pool_sensor_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class AddPoolScreen extends StatefulWidget {
  const AddPoolScreen({Key? key}) : super(key: key);

  @override
  State<AddPoolScreen> createState() => _AddPoolScreenState();
}

class _AddPoolScreenState extends State<AddPoolScreen> {
  final TextEditingController _poolNameController = TextEditingController();
  final TextEditingController _poolTopicController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PoolsListingScreenArgs;
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          args.clientName,
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
                      label: "Next",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(poolNameProvider.notifier).state =
                              _poolNameController.text.trim();
                          ref.read(poolTopicProvider.notifier).state =
                              _poolTopicController.text.trim();
                          ref.read(clientIdProvider.notifier).state =
                              args.clientUid;
                          ref.read(clientNameProvider.notifier).state =
                              args.clientName;
                          Navigator.pushNamed(context, PagePath.addPoolSensors);
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
