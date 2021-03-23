import 'package:buzzoole/blocs/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameTEC;
  TextEditingController _passwordTEC;

  @override
  void initState() {
    super.initState();
    _usernameTEC = TextEditingController();
    _passwordTEC = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFetchedState) {
            context.read<LoginBloc>().add(SessionFetchingEvent());
          } else if (state is SessionFetchedState) {
            Navigator.of(context).pushNamed('/movie_list');
          }
        },
        builder: (context, state) {
          if (state is FetchingState) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          } else if (state is InitialState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 100),
                  TextField(
                    controller: _usernameTEC,
                    obscureText: false,
                  ),
                  SizedBox(height: 100),
                  TextField(
                    controller: _passwordTEC,
                    obscureText: true,
                  ),
                  SizedBox(height: 100),
                  MaterialButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginFetchingEvent(
                          _usernameTEC.text, _passwordTEC.text));
                    },
                    elevation: 5,
                    highlightElevation: 10,
                    splashColor: Colors.white,
                    highlightColor: Colors.redAccent.withAlpha(100),
                    child: Container(
                      height: 100,
                      width: 100,
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
