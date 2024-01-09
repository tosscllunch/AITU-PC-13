import 'package:flutter/material.dart';
import 'registration.dart';
import 'globals.dart' as globals;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();
  bool emailError = false;
  bool emailError2 = false;
  bool passwordError = false;
  bool inputet = false;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                        "Вход",
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailTextFieldController,
                      onChanged: (value) {
                        setState(() {
                          emailError = false;
                          emailError2 = false;
                        });
                        if (emailTextFieldController.text.length >= 5 &&
                            passwordTextFieldController.text.isNotEmpty) {
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
                            : emailError2
                                ? 'Неправильно введены почта или пароль'
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
                    const SizedBox(height: 15),
                    const Text(
                      'Пароль',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordTextFieldController,
                      onChanged: (value) {
                        setState(() {
                          passwordError = false;
                          emailError2 = false;
                        });
                        if (emailTextFieldController.text.length >= 5 &&
                            passwordTextFieldController.text.isNotEmpty) {
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
                        // errorStyle: ,
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
                    const SizedBox(height: 35),
                    Row(
                      children: [
                        Expanded(
                            child: inputet
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        minimumSize: const Size(100, 50)),
                                    onPressed: () async {
                                      if (passwordTextFieldController
                                              .text.length <
                                          5) {
                                        setState(() {
                                          passwordError = true;
                                        });
                                      } else {
                                        final userinfo = await connection([
                                          emailTextFieldController.text,
                                          passwordTextFieldController.text
                                        ]);
                                        if (userinfo.isNotEmpty) {
                                          for (int i = 0;
                                              i < globals.userInfoFinal.length;
                                              i++) {
                                            globals.userInfoFinal[i] =
                                                userinfo[0][i + 1];
                                          }
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/homepage',
                                              (_) => false);
                                        } else {
                                          setState(() {
                                            emailError2 = true;
                                            passwordTextFieldController.text =
                                                '';
                                          });
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "Войти",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ))
                                : TextButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        minimumSize: const Size(100, 50)),
                                    onPressed: () {
                                      if (emailTextFieldController.text.length <
                                          5) {
                                        setState(() {
                                          emailError = true;
                                        });
                                      }
                                      if (passwordTextFieldController
                                              .text.length <
                                          5) {
                                        setState(() {
                                          passwordError = true;
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey,
                                      ),
                                      child: const Text(
                                        "Войти",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  )),
                      ],
                    ),
                    const SizedBox(height: 35),
                    Center(
                      child: TextButton(
                        child: const Text(
                          'Нет аккаунта? Регистрация',
                          style: TextStyle(fontSize: 20, color: Colors.teal),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Registration(
                                        email3Error: false,
                                      )));
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/homepage', (_) => false);
            },
          ),
        ),
      ),
    );
  }

  connect(userinfo, connection) async {
    var result = await connection.query(
        "SELECT * FROM users WHERE _email = '${userinfo[0].toString()}' AND _password = '${userinfo[1].toString()}'");

    return result;
  }

  connection(userinfo) async {
    var connection = globals.connection();

    await connection.open();
    return await connect(userinfo, connection);
  }
}
