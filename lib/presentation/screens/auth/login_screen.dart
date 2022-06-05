import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/common/utils/validators.dart';
import 'package:reimink_zwembaden_admin/data/models/network/network_models.dart';
import 'package:reimink_zwembaden_admin/data/repositories/admin_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AdminRepository _adminRepository = GetIt.I<AdminRepository>();
  String? emailError;
  String? passwordError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 70.0),
              Image.asset(
                Drawables.logo,
                width: 170,
                height: 66,
              ),
              const SizedBox(
                height: 7,
              ),
              const Text(
                Strings.tagline,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              const Text(
                Strings.login,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              CustomInputField(
                controller: emailController,
                label: Strings.email,
                hintText: Strings.email,
                icon: Icons.email,
                isObscure: false,
                errorText: emailError,
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: passwordController,
                label: Strings.password,
                hintText: Strings.password,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: showPassword
                      ? const Icon(
                          Icons.visibility,
                          color: AppColors.grey,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: AppColors.grey,
                        ),
                ),
                icon: Icons.lock,
                errorText: passwordError,
                isObscure: showPassword ? false : true,
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {
                  if (emailController.text.isNotEmpty &&
                      Validator.validateEmail(
                        emailController.text,
                      )) {
                    final status = await _adminRepository
                        .forgotPassword(emailController.text);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return status
                              ? AlertDialog(
                                  title: const Text(
                                    Strings.resetPassword,
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4.0,
                                      ),
                                      child: PrimaryButton(
                                        color: Colors.green,
                                        label: Strings.close,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                  content: Text(
                                    "${Strings.passwordResetLinkSentMessage} ${emailController.text}",
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              : AlertDialog(
                                  title: const Text(
                                    Strings.resetPassword,
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4.0,
                                      ),
                                      child: PrimaryButton(
                                        color: AppColors.blue,
                                        label: Strings.close,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                  content: const Text(
                                    Strings.passwordResetErrorMessage,
                                    textAlign: TextAlign.left,
                                  ),
                                );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(Strings.resetPassword),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                child: PrimaryButton(
                                  color: Colors.red[400],
                                  label: Strings.close,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                            content: const Text(
                              Strings.invalidResetEmailErrorMessage,
                              textAlign: TextAlign.left,
                            ),
                          );
                        });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    Text(
                      Strings.forgotPassword,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              PrimaryButton(
                label: Strings.login,
                onPressed: () async {
                  setState(() {
                    emailError = !Validator.validateEmail(emailController.text)
                        ? Strings.invalidEmail
                        : null;
                    passwordError =
                        !Validator.validatePassword(passwordController.text)
                            ? Strings.atleast6Characters
                            : null;
                  });
                  if (emailError == null && passwordError == null) {
                    showDialog(
                      context: context,
                      builder: (_) => const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                    );
                    final LoginResponse authState =
                        await _adminRepository.login(
                      AuthRequest(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                    Navigator.pop(context);
                    debugPrint("--------- Loader Popped ----------");
                    switch (authState.loginState) {
                      case LoginState.userNotFound:
                        setState(() {
                          emailError = Strings.noUserFoundMessage;
                        });
                        break;
                      case LoginState.wrongPassword:
                        {
                          setState(() {
                            passwordError = Strings.inCorrectPasswordMessage;
                          });
                        }
                        break;
                      case LoginState.success:
                        {
                          debugPrint("Login");
                        }
                        break;
                      default:
                    }
                  }
                },
              ),
              const SizedBox(height: 50),
              // const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    Strings.dontHaveAnAccount,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, PagePath.register);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        Strings.registerHere,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
