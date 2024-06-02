import 'package:faceDetector/constants/Assets.dart';
import 'package:faceDetector/constants/appColors.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

final _formKey = GlobalKey<FormState>();

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}

Widget _buildAppBar() {
  return AppBar(
    leading: BackButton(
      color: AppColors.linkColor,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

Widget _buildBody() {
  return CustomScrollView(
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _imageHeaderView(),
                  SizedBox(height: 15),
                  _titleHeaderView(),
                  SizedBox(height: 15),
                  _formView(),
                  SizedBox(height: 50),
                  _resetPasswordButtonView(context),
                ],
              ));
        }, childCount: 1),
      )
    ],
  );
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
          Text('Forgot Password',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: AppColors.titleText))
        ],
      )
    ],
  );
}

Widget _formView() {
  return Form(
    key: _formKey,
    child: TextFormField(
      autocorrect: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a valid email';
        } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
            // fontFamily: AppFontFamily.mainFont,
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: AppColors.normalText),
      ),
    ),
  );
}

Widget _resetPasswordButtonView(context) {
  return Container(
    height: 44,
    width: 186,
    child: RaisedButton(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          showDialog(
            context: context,
            builder: (_) => _buildAlert(context),
          );
        }
      },
      child: Text(
        "Reset Password",
        style: TextStyle(
          // fontFamily: AppFontFamily.mainFont,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textColor: Colors.white,
    ),
  );
}

Widget _buildAlert(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      margin: EdgeInsets.symmetric(horizontal: 30),
      height: 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              child: Text(
            'Link Sent',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )),
          Container(
              child: Text(
                  'A password reset link has been sent. Please check your email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ))),
          Container(
              child: FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            textColor: Colors.blue,
          ))
        ],
      ),
    ),
  );
}
