import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_1_carlos_flores/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Image.asset('assets/images/botonFondo.png'),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // Background color
                            ),
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(GoogleAuthEvent());
                            },
                            icon: Icon(
                              Icons.start,
                              color: Colors.white,
                            ),
                            label: Text("Iniciar con Google",
                                style: TextStyle(color: Colors.white))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
