import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/common/utils/validators.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/client_database_config_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/loader.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class AddDatabaseConfigScreen extends ConsumerStatefulWidget {
  const AddDatabaseConfigScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddDatabaseConfigScreenState();
}

class _AddDatabaseConfigScreenState
    extends ConsumerState<AddDatabaseConfigScreen> {
  final TextEditingController _hostNameController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _databaseNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _hostNameController.dispose();
    _portController.dispose();
    _userNameController.dispose();
    _databaseNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    ref.listen(addClientDatabaseConfigNotifierProvider,
        (_, ScreenState screenState) {
      if (screenState.stateType == StateType.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(screenState.data),
            backgroundColor: Colors.red,
            duration: const Duration(
              milliseconds: 800,
            ),
          ),
        );
      } else if (screenState.stateType == StateType.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(Strings.databaseConfigured),
            backgroundColor: Colors.green,
            duration: Duration(
              milliseconds: 800,
            ),
          ),
        );
        ref.refresh(clientDatabaseConfigProvider(id));
        Navigator.pop(context);
      }
    });
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(Strings.configureDatabase),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomInputField(
                              label: Strings.hostName,
                              controller: _hostNameController,
                              isObscure: false,
                              icon: Icons.public,
                              validator: InputValidator.requiredFieldValidator,
                            ),
                            const SizedBox(height: 10),
                            CustomInputField(
                              label: Strings.port,
                              controller: _portController,
                              isObscure: false,
                              icon: Icons.lan,
                              validator: InputValidator.requiredFieldValidator,
                            ),
                            const SizedBox(height: 10),
                            CustomInputField(
                              label: Strings.userName,
                              controller: _userNameController,
                              isObscure: false,
                              icon: Icons.person,
                              validator: InputValidator.requiredFieldValidator,
                            ),
                            const SizedBox(height: 10),
                            CustomInputField(
                              label: Strings.databaseName,
                              controller: _databaseNameController,
                              isObscure: false,
                              icon: Icons.storage,
                              validator: InputValidator.requiredFieldValidator,
                            ),
                            const SizedBox(height: 10),
                            CustomInputField(
                              label: Strings.password,
                              controller: _passwordController,
                              isObscure: false,
                              icon: Icons.password,
                              validator: InputValidator.requiredFieldValidator,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    label: Strings.addConnfiguratios,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final hostName = _hostNameController.text;
                        final port = _portController.text;
                        final userName = _userNameController.text;
                        final databaseName = _databaseNameController.text;
                        final password = _passwordController.text;

                        ref
                            .watch(addClientDatabaseConfigNotifierProvider
                                .notifier)
                            .addClientDatabaseConfig(
                              id: id,
                              hostName: hostName,
                              port: port,
                              userName: userName,
                              databaseName: databaseName,
                              password: password,
                            );
                      }
                    },
                  ),
                ],
              ),
            )),
          ),
        ),
        Consumer(
          builder: ((context, ref, child) {
            var screenState =
                ref.watch(addClientDatabaseConfigNotifierProvider);
            if (screenState.stateType == StateType.loading) {
              return const Loader();
            }
            return const SizedBox.shrink();
          }),
        ),
      ],
    );
  }
}
