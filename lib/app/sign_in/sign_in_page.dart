import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/app/sign_in/email_sign_in_page.dart';
import 'package:flutter_udemy_firebase/app/sign_in/sign_in_manager.dart';
import 'package:flutter_udemy_firebase/app/sign_in/sign_in_button.dart';
import 'package:flutter_udemy_firebase/app/sign_in/social_signin_button.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final SignInManager manager;
  final bool isLoading;

  const SignInPage({Key key, @required this.manager, @required this.isLoading})
      : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Provider<ValueNotifier<bool>>(
      builder: (context) => ValueNotifier<bool>(false),
      dispose: (context, valueNotifier) => valueNotifier.dispose(),
      child: Consumer<ValueNotifier<bool>>(
        builder: (context, valueNotifier, _) => Provider<SignInManager>(
          builder: (_) => SignInManager(auth: auth, isLoading: valueNotifier),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => ValueListenableBuilder<bool>(
              valueListenable: valueNotifier,
              builder: (context, isLoading, _) => SignInPage(
                manager: manager,
                isLoading: isLoading,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonimously();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } catch (e) {
      print(e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
//        fullscreenDialog: true,
        builder: (context) => EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Учет времени'),
        elevation: 2,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 50, child: _buildHeader()),
          SizedBox(
            height: 30,
          ),
          SocialSignInButton(
            color: Colors.white,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
            imageAsset: 'images/google-logo.png',
            text: 'Войти через Google',
            textColor: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          SocialSignInButton(
            color: Color(0xFF334D92),
            onPressed: () {},
            imageAsset: 'images/facebook-logo.png',
            text: 'Войти через Facebook',
            textColor: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            text: 'Войти через Email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'or',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SignInButton(
            text: 'Гостевой режим',
            textColor: Colors.white,
            color: Colors.deepOrange,
            onPressed: isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      "Sign in",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
    );
  }
}
