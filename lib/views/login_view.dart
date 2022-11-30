import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_scanner/util.dart';
import 'package:swd_scanner/views/prof_show_activity.dart';
import 'package:swd_scanner/views/scanning_view.dart';
import '../repo/models/login_classes.dart';
import '../view_models/login_view_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  String? username;
  String? password;
  late final ValueNotifier<bool> isLoadingLoginScreen;
  final storage = GetStorage('storage');

  redirectToScanningScreen() async {
    final prefs = await SharedPreferences.getInstance();
    ScreenSize().initializeSizes(context);
    print(dotenv.env['PRIVATE_KEY']);
    if (prefs.getStringList("JWT") != null) {
      if (!mounted) {}
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ProfShowActivity()));
    }
  }

  @override
  void initState() {
    super.initState();
    redirectToScanningScreen();
    isLoadingLoginScreen = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: isLoadingLoginScreen,
          builder: (BuildContext context, bool value, Widget? child) {
            if (isLoadingLoginScreen.value) {
              return const CircularProgressIndicator();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ScreenSize.screenWidth * 0.8,
                    child: TextFormField(
                      onChanged: (String value) {
                        username = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: ScreenSize.screenWidth * 0.8,
                    child: TextFormField(
                      onChanged: (String value) {
                        password = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (username == null ||
                          password == null ||
                          username == '' ||
                          password == '') {
                        var snackBar = const SnackBar(
                          duration: Duration(seconds: 2),
                          content: SizedBox(
                              height: 25,
                              child: Center(
                                  child: Text("enter username and password"))),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        isLoadingLoginScreen.value = true;
                        JWTResponse? jwtResponse;
                        try {
                          jwtResponse = await JwtViewModel()
                              .getJwt(username!.trim(), password!.trim());
                          final prefs = await SharedPreferences.getInstance();
                          isLoadingLoginScreen.value = false;
                          await prefs.setString('JWT', jwtResponse.JWT!);
                          storage.write('JWT', jwtResponse.JWT);
                          storage.write('Auth', true);
                          if (!mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScanningView(showId: 1)));
                        } on Exception catch (e) {
                          isLoadingLoginScreen.value = false;
                          var snackBar = SnackBar(
                            duration: const Duration(seconds: 5),
                            content: SizedBox(
                                height: 50,
                                child: Center(child: Text(e.toString()))),
                          );
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
