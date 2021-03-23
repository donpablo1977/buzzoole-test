import 'package:buzzoole/blocs/login/login_bloc.dart';
import 'package:buzzoole/presentation/widgets/buzzoole_loader.dart';
import 'package:buzzoole/utils/colors.dart';
import 'package:buzzoole/utils/size_engine.dart';
import 'package:buzzoole/utils/text_styles.dart';
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
                  child: BuzzooleLoader(),
                ));
          } else if (state is InitialState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(
                  top: BuzzooleSizingEngine().setDefaultSpace(context) * 4,
                  left: BuzzooleSizingEngine().setDefaultSpace(context),
                  right: BuzzooleSizingEngine().setDefaultSpace(context)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: BuzzooleSizingEngine().setDefaultSpace(context),
                    ),
                    Image.asset('assets/images/logo.png',
                        width:
                            BuzzooleSizingEngine().setThumbImageSize(context),
                        height:
                            BuzzooleSizingEngine().setThumbImageSize(context)),
                    SizedBox(
                      height: BuzzooleSizingEngine().setDefaultSpace(context),
                    ),
                    TextField(
                      // onEditingComplete: () => node.nextFocus(),
                      onTap: () => _usernameTEC.clear(),
                      autofocus: true,
                      cursorWidth: 1,
                      obscureText: false,
                      controller: _usernameTEC,
                      cursorColor: BuzzooleColors().buzzooleMainColor,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: BuzzooleColors().buzzooleMainColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: BuzzooleColors().buzzooleMainColor))),
                      style: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMaximumFontSize(context),
                          BuzzooleColors().buzzooleMainColor),
                    ),
                    SizedBox(
                      height:
                          BuzzooleSizingEngine().setDefaultSpace(context) * 2,
                    ),
                    TextField(
                      // onEditingComplete: () => node.unfocus(),
                      onTap: () => _passwordTEC.clear(),
                      onSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                        context.read<LoginBloc>().add(LoginFetchingEvent(
                            _usernameTEC.text, _passwordTEC.text));
                      },
                      autofocus: true,
                      cursorWidth: 1,
                      obscureText: true,
                      controller: _passwordTEC,
                      cursorColor: BuzzooleColors().buzzooleMainColor,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: BuzzooleColors().buzzooleMainColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: BuzzooleColors().buzzooleMainColor))),
                      style: BuzzooleTextStyles().setBlackStyle(
                          BuzzooleSizingEngine().setMaximumFontSize(context),
                          BuzzooleColors().buzzooleMainColor),
                    ),
                    SizedBox(
                      height:
                          BuzzooleSizingEngine().setDefaultSpace(context) * 4,
                    ),
                    MaterialButton(
                      color: BuzzooleColors().buzzooleMainColor,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<LoginBloc>().add(LoginFetchingEvent(
                            _usernameTEC.text, _passwordTEC.text));
                      },
                      shape: CircleBorder(),
                      elevation: 5,
                      highlightElevation: 10,
                      splashColor: Colors.white,
                      highlightColor: Colors.redAccent.withAlpha(100),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(200)),
                        ),
                        height: 50,
                        width: 50,
                        child: Icon(Icons.check, size: 15, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
