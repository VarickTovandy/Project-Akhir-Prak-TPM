import 'package:project_manga/pages/home_page.dart';
import 'package:project_manga/pages/root_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SharedPreferences prefs;

  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }

  void checkIsLogin() async {
    prefs = await SharedPreferences.getInstance();

    bool? isLogin = (prefs.getString('username') != null) ? true : false;

    if(isLogin && mounted){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) => RootApp(),
      ),
              (route) => false);
    }
  }

  @override
  void dispose(){
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                  )
              ),
              child: Image.network(
                'https://pbs.twimg.com/media/D_Rjo3KU8AAdW2T?format=jpg&name=small',
              ),
            ),
            const SizedBox(height: 10),
            const Text('Login',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black)),
            const SizedBox(height: 10,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _usernameController,
                          cursorColor: const Color(0xffc1071e),
                          style: const TextStyle(fontSize: 15, color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.people),
                            filled: true,
                            fillColor: Colors.white24,
                            labelText: 'Username',
                            labelStyle: const TextStyle(color: Colors.black),
                            hintText: 'Input your Username',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Color(0xFFA8C1D2),
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFF3CA9FC),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _passwordController,
                          style: const TextStyle(fontSize: 15, color: Colors.black),
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.white24,
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.black),
                            hintText: 'Input your Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Color(0xFFA8C1D2),
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFF3CA9FC),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: Builder(builder: (context) {
                          return ElevatedButton(
                            onPressed: () async {
                              String username = _usernameController.text;
                              String password = _passwordController.text;


                              String text = '';
                              if (username == "admin" && password == "admin") {
                                await prefs.setString('username', username);

                                if(mounted){
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                    builder: (context) => RootApp(),
                                  ),
                                          (route) => false);
                                }

                                text = "Login Berhasil!";
                                _isObscure = true;
                              } else {
                                text = "Login Gagal";
                                _isObscure = false;
                              }
                              SnackBar snackBar = SnackBar(
                                content: Text(text),
                                duration: const Duration(seconds: 2),
                                backgroundColor: (_isObscure) ? Colors.green : Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child:
                            const Text('Login', style: TextStyle(fontSize: 15)),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF0A3F67),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}