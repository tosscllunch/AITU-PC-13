// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/registration.dart';
import 'registration2.dart';
import 'package:email_otp/email_otp.dart';
import 'globals.dart' as globals;

class Registration15 extends StatefulWidget {
  final List userInfo;
  final EmailOTP myauth;

  const Registration15({Key? key, required this.userInfo, required this.myauth})
      : super(key: key);
  @override
  State<Registration15> createState() => _Registration15();
}

class _Registration15 extends State<Registration15> {
  final codeTextFieldController = TextEditingController();

  bool inputet = false;
  bool nameError = false;

  late bool done;

  int code = 0;

  void awaiting() async {
    final email = await connection(widget.userInfo[0]);

    if (email.length != 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Registration(email3Error: true)));
    } else {
      setState(() {
        done = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    awaiting();
    done = false;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 40,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          body: done
              ? Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Верификация почты",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Код',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                            // textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: codeTextFieldController,
                            onChanged: (value) {
                              code = int.parse(value);
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.teal[200],
                              errorText: nameError
                                  ? 'Пожалуйста, введите код из почты'
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.teal,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: 'Код',
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    minimumSize: const Size(100, 50)),
                                onPressed: () async {
                                  if (await widget.myauth.verifyOTP(
                                          otp: codeTextFieldController.text) ==
                                      true) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Registration2(
                                                  userInfo: widget.userInfo,
                                                )));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("OTP is verified"),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Invalid OTP"),
                                    ));
                                  }
                                },
                                child: const Text(
                                  "Проверить код",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ));
  }

  register(userinfo, connection) async {
    await connection.execute(
        "INSERT INTO users (_email, _password, _name, _surname, _city, _usertype, _specialization, _height, _weight, _date, _narrow_specialization) VALUES ('${userinfo[0].toString()}', '${userinfo[1].toString()}', '${userinfo[2].toString()}', '${userinfo[3].toString()}', '${userinfo[4].toString()}', '${userinfo[5].toString()}', '${userinfo[6].toString()}', '${userinfo[7].toString()}', '${userinfo[8].toString()}', '${userinfo[9].toString()}', '${userinfo[10].toString()}')");
  }

  registration(userinfo) async {
    var connection = globals.connection();

    await connection.open();
    await register(userinfo, connection);
  }

  connect(email, connection) async {
    var result = await connection
        .query("SELECT * FROM users WHERE _email = '${email.toString()}'");

    if (result.length == 0) {
      return [];
    } else {
      return result;
    }
  }

  connection(email) async {
    var connection = globals.connection();

    await connection.open();
    return await connect(email, connection);
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController email = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: email,
                          decoration:
                              const InputDecoration(hintText: "User Email")),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          myauth.setConfig(
                              appEmail: "anurmashev@gmail.com",
                              appName: "MUA",
                              userEmail: email.text,
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
                        },
                        child: const Text("Отправить код")),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: otp,
                          decoration:
                              const InputDecoration(hintText: "Введите код")),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            minimumSize: const Size(100, 50)),
                        onPressed: () async {
                          if (await myauth.verifyOTP(otp: otp.text) == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP is verified"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Invalid OTP"),
                            ));
                          }
                        },
                        child: const Text("Подтвердить")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
