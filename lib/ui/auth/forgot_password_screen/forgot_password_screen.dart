import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String email = "";

    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/images/parkin_logo.svg",
                      width: 250,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 35),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else {
                            if (!value.contains("@") || !value.contains(".")) {
                              return "Please enter an email";
                            } else {
                              email = value;
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "example@mail.com",
                            label: const Text("Email"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Reset Password',
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.w700),
                          ),
                          Consumer<AuthView>(
                            builder:
                                (BuildContext context, value, Widget? child) {
                              if (value.authProcess == AuthProcess.idle) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: const Color(0xff132137),
                                  ),
                                  child: InkWell(
                                    radius: 32,
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        await value
                                            .sendPasswordResetEmail(email)
                                            .then((result) {
                                          if (result is String) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(result),
                                              ),
                                            );
                                          }else{
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text("We sent an email to reset your password."),
                                              ),
                                            );
                                            value.authState = AuthState.signIn;
                                          }
                                        });
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Consumer<AuthView>(builder:
                          (BuildContext context, value, Widget? child) {
                        return TextButton(
                          onPressed: () {
                            value.authState = AuthState.signIn;
                          },
                          style: const ButtonStyle(),
                          child: const Text(
                            'Or you can try again to sign in',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff4c505b),
                                fontSize: 18),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
