import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reimink_zwembaden_admin/data/constants/colors/Colors.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool showpassword = false;
  final TextEditingController inviteController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final AuthController controller = AuthController();
  String? emailErr;
  String? usernameErr;
  String? passwordErr;
  String? inviteErr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 70,
              ),
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
                "Registreren",
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
                controller: inviteController,
                label: "Inlogcode",
                hintText: "Voer de uitnodigingscode in",
                icon: Icons.pin,
                isObscure: false,
                errorText: inviteErr,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                controller: userNameController,
                label: "gebruikersnaam",
                hintText: "gebruikersnaam",
                icon: Icons.pin,
                isObscure: false,
                errorText: usernameErr,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                controller: emailController,
                label: "Email",
                hintText: "Email",
                icon: Icons.email,
                isObscure: false,
                errorText: emailErr,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                controller: passwordController,
                label: "Wachtwoord",
                hintText: "Wachtwoord",
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      showpassword = !showpassword;
                    });
                  },
                  child: showpassword
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
                errorText: passwordErr,
                isObscure: showpassword ? false : true,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
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
              const SizedBox(
                height: 50,
              ),
              PrimaryButton(
                label: "Registreren",
                onPressed: () async {
                  setState(() {
                    inviteErr = inviteController.text != "1321"
                        ? "ongeldige uitnodigingscode"
                        : null;
                    usernameErr = userNameController.text.isEmpty
                        ? "gebruikersnaam is vereist"
                        : null;
                    emailErr =
                        !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(
                      emailController.text,
                    )
                            ? "Ongeldig e-mail"
                            : null;
                    passwordErr = passwordController.text.length < 6
                        ? "Het wachtwoord moet op zijn minst 6 tekens lang zijn"
                        : null;
                  });
                  if (emailErr == null &&
                      usernameErr == null &&
                      passwordErr == null &&
                      inviteErr == null) {
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
                    final authState =
                        await controller.registerWithEmailAndPassword(
                      userEmail: emailController.text,
                      userPassword: passwordController.text,
                    );
                    switch (authState) {
                      case RegisterationState.emailAlreadyExists:
                        Navigator.pop(context);
                        setState(() {
                          emailErr =
                              "Op voorwaarde dat e-mail al in gebruik is";
                        });
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     backgroundColor: Color(0xFFf7f6f6).withOpacity(0.1),
                        //     content: Text(
                        //       'The provided email is already in use.',
                        //       style: CustomTextStyle.bodyWhite(),
                        //     ),
                        //   ),
                        // );
                        break;
                      case RegisterationState.successful:
                        {
                          final user = FirebaseAuth.instance.currentUser!;
                          await DatabaseController().setUsername(
                            uid: user.uid,
                            userName: userNameController.text,
                            email: emailController.text,
                          );
                          await user.sendEmailVerification();
                          SchedulerBinding.instance!
                              .addPostFrameCallback((_) async {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                'verifyEmail', (Route<dynamic> route) => false);
                          });
                        }
                        break;
                      default:
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User Registeration Failed'),
                          ),
                        );
                    }
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Heeft u al een account?",
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
                      Navigator.popAndPushNamed(context, "loginScreen");
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Hier inloggen",
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
