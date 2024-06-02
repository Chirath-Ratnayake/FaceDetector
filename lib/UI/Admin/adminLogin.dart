import 'package:faceDetector/UI/Admin/adminHome.dart';
import 'package:faceDetector/UI/Auth/ForgotPassword.dart';
import 'package:faceDetector/constants/Assets.dart';
import 'package:faceDetector/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AdminLoginView extends StatefulWidget {
  @override
  _AdminLoginViewState createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends State<AdminLoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  bool _showIcon = false;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _imageHeaderView(),
                SizedBox(height: 50),
                _titleHeaderView(),
                SizedBox(height: 10),
                _formView(),
                SizedBox(height: 10),
                _forgotPasswordView(),
                SizedBox(height: 50),
                _loginButtonView(),
                SizedBox(height: 50),
                // _buildLoginOptions(),
                // SizedBox(height: 50),
                // _registerBottomView()
              ],
            )));
  }

  Widget _imageHeaderView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset(
              Assets.appLogo,
              width: 200.0,
              height: 200.0,
            )
          ],
        )
      ],
    );
  }

  Widget _titleHeaderView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Text('Login',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: Colors.amber))
          ],
        )
      ],
    );
  }

  //Form Widgets
  Widget _formView() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_emailTextFieldView(context), _passwordTextFieldView()],
      ),
    );
  }

  Widget _emailTextFieldView(context) {
    return TextFormField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            setState(() {
              _isValid = false;
              _showIcon = true;
            });
          } else {
            setState(() {
              _isValid = true;
              _showIcon = true;
            });
          }
        }
      },
      autocorrect: false,
      validator: (value) {
        if (value.isEmpty) {
          setState(() {
            _isValid = false;
            _showIcon = true;
          });
          return 'Please enter a valid email';
        } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          setState(() {
            _isValid = false;
            _showIcon = true;
          });
          return 'Please enter a valid email';
        } else {
          setState(() {
            _showIcon = true;
            _isValid = true;
            email = value;
          });
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: _showIcon == true
            ? Icon(
                _isValid == true && _showIcon == true
                    ? Icons.check_circle
                    : MaterialIcons.cancel,
                color: _isValid == true && _showIcon == true
                    ? Colors.green
                    : Colors.red)
            : null,
        labelText: 'Email',
        labelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: Colors.amber),
      ),
    );
  }

  Widget _passwordTextFieldView() {
    return TextFormField(
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Colors.amber)),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _isValid = false;
            });
            return 'Please enter a password';
          } else {
            setState(() {
              _isValid = true;
              password = value;
            });
          }
          return null;
        });
  }

  //Action Buttons
  Widget _forgotPasswordView() {
    return Align(
      alignment: Alignment.centerRight,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Text(
          "Forgot Password?",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.blue),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPassword()),
        ),
      ),
    );
  }

  Widget _loginButtonView() {
    return Container(
      height: 44,
      width: 148,
      child: RaisedButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            if (email == "chirathr@gmail.com" && password == "12345678") {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AdminHome()));
            }
            // loginNetworkRequest();
          }
        },
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textColor: Colors.white,
      ),
    );
  }
}