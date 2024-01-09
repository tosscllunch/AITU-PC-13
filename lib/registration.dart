import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration1_5.dart';
import 'registration2.dart';
import 'package:email_otp/email_otp.dart';

class Registration extends StatefulWidget {
  final bool email3Error;
  const Registration({Key? key, required this.email3Error}) : super(key: key);
  @override
  State<Registration> createState() => _Registration();
}

class _Registration extends State<Registration> {
  final emailTextFieldController = TextEditingController();
  final password1TextFieldController = TextEditingController();
  final password2TextFieldController = TextEditingController();

  final List userInfo = <String>[
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " "
  ];
  bool inputet = false;
  bool emailError = false;
  bool email2Error = false;
  bool passwordError = false;
  bool password2Error = false;
  bool password3Error = false;

  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 40,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Регистрация",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'Почта',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                        // textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: emailTextFieldController,
                        onChanged: (value) {
                          setState(() {
                            emailError = false;
                            email2Error = false;
                          });
                          if (emailTextFieldController.text.contains('@') &&
                              emailTextFieldController.text.contains('.') &&
                              emailTextFieldController.text.length > 5 &&
                              password1TextFieldController.text.length >= 5 &&
                              password2TextFieldController.text.length >= 5) {
                            setState(() {
                              inputet = true;
                            });
                          } else {
                            setState(() {
                              inputet = false;
                            });
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.teal[200],
                          errorText: emailError
                              ? 'Некорректный формат почты'
                              : email2Error
                                  ? null
                                  : widget.email3Error
                                      ? 'Почта уже зарегистрирована'
                                      : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.teal,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: 'Почта',
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Пароль',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: password1TextFieldController,
                        onChanged: (value) {
                          setState(() {
                            passwordError = false;
                            password2Error = false;
                            password3Error = false;
                          });
                          if (emailTextFieldController.text.contains('@') &&
                              emailTextFieldController.text.contains('.') &&
                              emailTextFieldController.text.length > 5 &&
                              password1TextFieldController.text.length >= 5 &&
                              password2TextFieldController.text.length >= 5) {
                            setState(() {
                              inputet = true;
                            });
                          } else {
                            setState(() {
                              inputet = false;
                            });
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.teal[200],
                          errorText: passwordError
                              ? 'Пароль должен содержать не менее 5 символов'
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.teal,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: 'Пароль',
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Подтвердите пароль',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: password2TextFieldController,
                        onChanged: (value) {
                          setState(() {
                            passwordError = false;
                            password2Error = false;
                            password3Error = false;
                          });
                          if (emailTextFieldController.text.contains('@') &&
                              emailTextFieldController.text.contains('.') &&
                              emailTextFieldController.text.length > 5 &&
                              password1TextFieldController.text.length >= 5 &&
                              password2TextFieldController.text.length >= 5) {
                            setState(() {
                              inputet = true;
                            });
                          } else {
                            setState(() {
                              inputet = false;
                            });
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.teal[200],
                          errorText: password2Error
                              ? 'Пароль должен содержать не менее 5 символов'
                              : password3Error
                                  ? 'Пароли не совпадают'
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.teal,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: 'Пароль',
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                              child: inputet
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          minimumSize: const Size(100, 50)),
                                      onPressed: () async {
                                        if (password2TextFieldController.text !=
                                            password1TextFieldController.text) {
                                          setState(() {
                                            password3Error = true;
                                          });
                                        } else {
                                          userInfo[0] =
                                              emailTextFieldController.text;
                                          userInfo[1] =
                                              password1TextFieldController.text;
                                          myauth.setConfig(
                                              appEmail: "anurmashev@gmail.com",
                                              appName: "MUA",
                                              userEmail: userInfo[0],
                                              otpLength: 6,
                                              otpType: OTPType.digitsOnly);
                                          if (await myauth.sendOTP() == true) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text("Код отправлен"),
                                            ));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Не получилось отправить код. Проверьте интернет соединение"),
                                            ));
                                          }
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Registration15(
                                                          userInfo: userInfo,
                                                          myauth: myauth)));
                                        }
                                      },
                                      child: const Text(
                                        "Выслать код подтверждение",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ))
                                  : TextButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          minimumSize: const Size(100, 50)),
                                      onPressed: () async {
                                        if (!emailTextFieldController.text
                                                .contains('@') ||
                                            !emailTextFieldController.text
                                                .contains('.') ||
                                            emailTextFieldController
                                                    .text.length <
                                                5) {
                                          setState(() {
                                            emailError = true;
                                          });
                                        }
                                        if (password1TextFieldController
                                                .text.length <
                                            5) {
                                          setState(() {
                                            passwordError = true;
                                          });
                                        }
                                        if (password2TextFieldController
                                                .text.length <
                                            5) {
                                          setState(() {
                                            password2Error = true;
                                          });
                                        }
                                        if (password2TextFieldController.text !=
                                            password1TextFieldController.text) {
                                          setState(() {
                                            password3Error = true;
                                          });
                                        }
                                      },
                                      child: const Text(
                                        "Выслать код и продолжить",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Registration2(userInfo: userInfo)));
              },
            ),
          ),
        ));
  }
}
