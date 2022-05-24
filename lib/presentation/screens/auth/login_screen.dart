import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reimink_zwembaden_admin/data/constants/colors/Colors.dart';
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
                "images/logo.jpg",
                width: 170,
                height: 66,
              ),
              const SizedBox(
                height: 7,
              ),
              const Text(
                "zwembaden | wellness | waterfun",
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
                "Inloggen",
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
                label: "Email",
                hintText: "Email",
                icon: Icons.email,
                isObscure: false,
                errorText: emailError,
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: passwordController,
                label: "Password",
                hintText: "Password",
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
                      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(
                        emailController.text,
                      )) {
                    final status =
                        await controller.forgetPassword(emailController.text);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return status
                              ? AlertDialog(
                                  title: const Text(
                                      "Wachtwoord opnieuw instellen"),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4.0,
                                      ),
                                      child: PrimaryButton(
                                        color: Colors.green,
                                        label: "Close",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                  content: Text(
                                    "Er is een link voor het opnieuw instellen van uw wachtwoord naar uw e-mailadres verzonden: ${emailController.text}",
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              : AlertDialog(
                                  title: const Text(
                                      "Wachtwoord opnieuw instellen"),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4.0,
                                      ),
                                      child: PrimaryButton(
                                        color: AppColors.blue,
                                        label: "Close",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                  content: const Text(
                                    "Wachtwoord opnieuw instellen is niet voltooid. Controleer uw e-mail of probeer het opnieuw",
                                    textAlign: TextAlign.left,
                                  ),
                                );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Wachtwoord opnieuw instellen"),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                child: PrimaryButton(
                                  color: Colors.red[400],
                                  label: "Close",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                            content: const Text(
                              "Geef een geldig e-mailadres op om uw wachtwoord opnieuw in te stellen",
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
                      "Wachtwoord vergeten?",
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
                label: "Inloggen",
                onPressed: () async {
                  setState(() {
                    emailError =
                        !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(
                      emailController.text,
                    )
                            ? "Ongeldig e-mail"
                            : null;
                    passwordError = passwordController.text.length < 6
                        ? "Tenminste 6 tekens"
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
                    final authState = await controller.loginWithEmailPassword(
                        emailController.text, passwordController.text);
                    Navigator.pop(context);
                    switch (authState) {
                      case LoginState.userNotFound:
                        // Navigator.pop(context);
                        setState(() {
                          emailError =
                              "Geen gebruiker gevonden voor deze e-mail";
                        });
                        break;
                      case LoginState.wrongPassword:
                        {
                          // Navigator.pop(context);
                          setState(() {
                            passwordError = "Uw wachtwoord is onjuist";
                          });
                        }
                        break;
                      case LoginState.success:
                        {
                          debugPrint("Login");
                          // Navigator.pop(context);
                          // print("User Logged In Successfully");
                          SchedulerBinding.instance!
                              .addPostFrameCallback((_) async {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                'landing', (Route<dynamic> route) => false);
                          });
                        }
                        break;
                      default:
                    }
                  }
                },
              ),
              SizedBox(height: 200.h),
            ],
          ),
        ),
      ),
    );
  }
}
