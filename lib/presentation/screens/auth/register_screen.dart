import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/common/utils/validators.dart';
import 'package:reimink_zwembaden_admin/data/models/network/network_models.dart';
import 'package:reimink_zwembaden_admin/data/repositories/admin_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  bool showpassword = false;
  final TextEditingController inviteController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AdminRepository _adminRepository = GetIt.I<AdminRepository>();
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
                Strings.register,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              // CustomInputField(
              //   controller: inviteController,
              //   label: "Inlogcode",
              //   hintText: "Voer de uitnodigingscode in",
              //   icon: Icons.pin,
              //   isObscure: false,
              //   errorText: inviteErr,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              CustomInputField(
                controller: userNameController,
                label: Strings.userName,
                hintText: Strings.userName,
                icon: Icons.person,
                isObscure: false,
                errorText: usernameErr,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                controller: emailController,
                label: Strings.email,
                hintText: Strings.email,
                icon: Icons.email,
                isObscure: false,
                errorText: emailErr,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                controller: passwordController,
                label: Strings.password,
                hintText: Strings.password,
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
                    Strings.forgotPassword,
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
                label: Strings.register,
                onPressed: () async {
                  setState(() {
                    usernameErr = userNameController.text.isEmpty
                        ? Strings.userNameRequired
                        : null;
                    emailErr = !Validator.validateEmail(emailController.text)
                        ? Strings.invalidEmail
                        : null;
                    passwordErr =
                        !Validator.validatePassword(passwordController.text)
                            ? Strings.passwordLengthValidationMessage
                            : null;
                  });
                  if (emailErr == null &&
                      usernameErr == null &&
                      passwordErr == null) {
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
                    final RegisterResponse authState =
                        await _adminRepository.register(
                      AuthRequest(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                    switch (authState.registerationState) {
                      case RegisterationState.emailAlreadyExists:
                        Navigator.pop(context);
                        setState(() {
                          emailErr = Strings.emailAlreadyInUse;
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
                          // await DatabaseController().setUsername(
                          //   uid: user.uid,
                          //   userName: userNameController.text,
                          //   email: emailController.text,
                          // );
                          await user.sendEmailVerification();
                          SchedulerBinding.instance!
                              .addPostFrameCallback((_) async {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                PagePath.verifyEmail,
                                (Route<dynamic> route) => false);
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
                    Strings.alreadyHaveAnAccount,
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
                      Navigator.popAndPushNamed(context, PagePath.login);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        Strings.loginHere,
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
