import 'package:faceDetector/constants/Assets.dart';
import 'package:faceDetector/constants/appColors.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RegisterView extends StatefulWidget {
  @override
  LoginViewState createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  bool _showIcon = false;
  String _pswd = "";

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // Future registerUser() async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: "barry.allen@example.com",
  //             password: "SuperSecretPassword!");
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
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
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _imageHeaderView(),
                    SizedBox(height: 15),
                    _titleHeaderView(),
                    SizedBox(height: 10),
                    _orSeperatorView(),
                    SizedBox(height: 10),
                    _formView(),
                    SizedBox(height: 30),
                    _privacyView(),
                    SizedBox(height: 30),
                    _registerButtonView(context),
                    SizedBox(height: 50),
                    _registerBottomView()
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
            Text('Register',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: AppColors.titleText))
          ],
        )
      ],
    );
  }

  Widget _orSeperatorView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _seperatorLine(),
        SizedBox(width: 15),
        Text(
          'or',
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 18, color: Colors.grey),
        ),
        SizedBox(width: 10),
        _seperatorLine()
      ],
    );
  }

  Widget _seperatorLine() {
    return Container(
      width: (MediaQuery.of(context).size.width - 90) / 2,
      height: 1,
      color: Colors.grey,
    );
  }

  //Form Widgets
  Widget _formView() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _emailTextFieldView(context),
          _mobileTextFieldView(),
          _passwordTextFieldView(),
          _confirmPasswordTextFieldView()
        ],
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
            fontWeight: FontWeight.w400, fontSize: 17, color: Colors.amber),
      ),
    );
  }

  Widget _mobileTextFieldView() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Enter an Mobile Number';
        } else if (!RegExp(r"^(\+)?([ 0-9]){10,16}$").hasMatch(value)) {
          return 'Please Enter a valid phone number with the country code';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Mobile Number',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 17, color: Colors.amber)),
    );
  }

  Widget _passwordTextFieldView() {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Enter a Password';
        } else {
          _pswd = value;
          return null;
        }
      },
      decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 17, color: Colors.amber)),
    );
  }

  Widget _confirmPasswordTextFieldView() {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value != _pswd) {
          return 'Passwords do not match';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          labelText: 'Confirm Password',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 17, color: Colors.amber)),
    );
  }

  //Action Buttons
  Widget _registerButtonView(context) {
    return Container(
      height: 44,
      width: 148,
      child: RaisedButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        onPressed: () => {
          if (_formKey.currentState.validate())
            {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationView()))
              // AuthRegisterResponse _authRegisterResponse =
              // AuthApi().authPostRegister("application/json", "deviceId", "APPLE", "Kasun", "Sandeep", "kasun.emedia+2@gmail.com", "12345678", "12345678");
              // User authUser = _authRegisterResponse.payload
              // registerNetworkRequest()
            }
        },
        child: Text(
          "Register",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textColor: Colors.white,
      ),
    );
  }

  // Widget _buildLoginOptions() {
  //   return Container(
  //     height: 220,
  //     margin: new EdgeInsets.symmetric(horizontal: 0.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Container(
  //           height: 44,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(10),
  //                 topRight: Radius.circular(10),
  //                 bottomLeft: Radius.circular(10),
  //                 bottomRight: Radius.circular(10)),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.5),
  //                 spreadRadius: 3,
  //                 blurRadius: 7,
  //                 offset: Offset(0, 3), // changes position of shadow
  //               ),
  //             ],
  //           ),
  //           child: FlatButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(7)),
  //             color: Colors.white,
  //             onPressed: () {},
  //             child: Row(
  //               children: [
  //                 Image.asset(Assests.appleLogo),
  //                 SizedBox(width: 60),
  //                 Text(
  //                   "Continue with Apple",
  //                   style: TextStyle(
  //                     fontFamily: AppFontFamily.mainFont,
  //                     fontSize: 14,
  //                     color: Colors.blue,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           height: 44,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(10),
  //                 topRight: Radius.circular(10),
  //                 bottomLeft: Radius.circular(10),
  //                 bottomRight: Radius.circular(10)),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.5),
  //                 spreadRadius: 3,
  //                 blurRadius: 7,
  //                 offset: Offset(0, 3), // changes position of shadow
  //               ),
  //             ],
  //           ),
  //           child: FlatButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(7)),
  //             color: Colors.white,
  //             onPressed: () {},
  //             child: Row(
  //               children: [
  //                 Image.asset(Assests.facebookLogo),
  //                 SizedBox(width: 60),
  //                 Text(
  //                   "Continue with Facebook",
  //                   style: TextStyle(
  //                     fontFamily: AppFontFamily.mainFont,
  //                     fontSize: 14,
  //                     color: Colors.blue,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           height: 44,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(10),
  //                 topRight: Radius.circular(10),
  //                 bottomLeft: Radius.circular(10),
  //                 bottomRight: Radius.circular(10)),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.5),
  //                 spreadRadius: 3,
  //                 blurRadius: 7,
  //                 offset: Offset(0, 3), // changes position of shadow
  //               ),
  //             ],
  //           ),
  //           child: FlatButton(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(7)),
  //             color: Colors.white,
  //             onPressed: () {},
  //             child: Row(
  //               children: [
  //                 Image.asset(Assests.googleLogo),
  //                 SizedBox(width: 60),
  //                 Text(
  //                   "Continue with Google",
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.blue,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _privacyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "By Signing, you agree to our",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.amber,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              padding: EdgeInsets.all(0.0),
              child: Text(
                "Terms & Conditions",
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.amber),
              ),
              onPressed: () => {},
            ),
            SizedBox(width: 5),
            Text(
              "and",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.amber,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 5),
            FlatButton(
              padding: EdgeInsets.all(0.0),
              child: Text(
                "Privacy Policy.",
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.amber),
              ),
              onPressed: () => {},
            ),
          ],
        )
      ],
    );
  }

  Widget _registerBottomView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?'),
        SizedBox(width: 5),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
