import 'package:faceDetector/UI/Home/home.dart';
import 'package:faceDetector/UI/Home/profile.dart';
import 'package:faceDetector/db/database.dart';
import 'package:faceDetector/services/facenet.service.dart';
import 'package:faceDetector/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';

class User {
  String user;
  String password;

  User({@required this.user, @required this.password});

  static User fromDB(String dbuser) {
    return new User(user: dbuser.split(':')[0], password: dbuser.split(':')[1]);
  }
}

class AuthActionButton extends StatefulWidget {
  AuthActionButton(this._initializeControllerFuture, {@required this.onPressed, @required this.isLogin});
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isLogin;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  /// service injection
  final FaceNetService _faceNetService = FaceNetService();
  final DataBaseService _dataBaseService = DataBaseService();

  final TextEditingController _userTextEditingController = TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController = TextEditingController(text: '');

  User predictedUser;

  Future _signUp(context) async {

    /// gets predicted data from facenet service (user face detected)
    List predictedData = _faceNetService.predictedData;
    String user = _userTextEditingController.text;
    String password = _passwordTextEditingController.text;

    /// creates a new user in the 'database'
    await _dataBaseService.saveData(user, password, predictedData);

    /// resets the face stored in the face net sevice
    this._faceNetService.setPredictedData(null);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeView()));
  }

  Future _signIn(context) async {
    String password = _passwordTextEditingController.text;

    if (this.predictedUser.password == password) {
      Navigator.push(
          context,
          MaterialPageRoute(
              // builder: (BuildContext context) => ProfileView(
              //       username: this.predictedUser.user,
              //     )));
                  builder: (BuildContext context) => HomeView()));
    } else {
      print(" WRONG PASSWORD!");
    }
  }

  String _predictUser() {
    String userAndPass = _faceNetService.predict();
    return userAndPass?? null;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: widget.isLogin ? Text('Sign in') : Text('Sign up'),
      icon: Icon(Icons.camera_alt),
      // Provide an onPressed callback.
      onPressed: () async {
        try {
          // Ensure that the camera is initialized.
          await widget._initializeControllerFuture;
          // onShot event (takes the image and predict output)
          bool faceDetected = await widget.onPressed();

          if (faceDetected) {
            // if (widget.isLogin) {
              var userAndPass = _predictUser();
              if (userAndPass != null) {
                this.predictedUser = User.fromDB(userAndPass);
              }
            // }
            Scaffold.of(context).showBottomSheet((context) => signSheet(context));
          }
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
    );
  }

  signSheet(context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 300,
      child: Column(
        children: [
          widget.isLogin && predictedUser != null
              ? Container(
                  child: Text(
                    'Welcome back, ' + predictedUser.user + '! 😄',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : widget.isLogin
                  ? Container(
                      child: Text(
                      'User not found 😞',
                      style: TextStyle(fontSize: 20),
                    ))
                  : Container(),
          !widget.isLogin && predictedUser == null 
              ? TextField(
                  controller: _userTextEditingController,
                  decoration: InputDecoration(labelText: "Your Name"),
                )
                : !widget.isLogin
                  ? Container(
                      child: Text(
                      'User already exist 😞',
                      style: TextStyle(fontSize: 20),
                    ))
              : Container(),
          widget.isLogin && predictedUser == null
              ? Container()
              : !widget.isLogin && predictedUser != null 
              ?  Container() 
              : TextField(
                  controller: _passwordTextEditingController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
          widget.isLogin && predictedUser != null
              ? RaisedButton(
                  child: Text('Login'),
                  onPressed: () async {
                    _signIn(context);
                  },
                )
              : !widget.isLogin && predictedUser == null
                  ? RaisedButton(
                      child: Text('Sign Up!'),
                      onPressed: () async {
                        await _signUp(context);
                      },
                    )
                  : Container(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
