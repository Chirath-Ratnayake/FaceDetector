import 'package:camera/camera.dart';
import 'package:faceDetector/UI/Admin/adminLogin.dart';
import 'package:faceDetector/UI/Auth/ForgotPassword.dart';
import 'package:faceDetector/UI/Auth/register.dart';
import 'package:faceDetector/constants/Assets.dart';
import 'package:faceDetector/constants/sign-in.dart';
import 'package:faceDetector/constants/sign-up.dart';
import 'package:faceDetector/db/database.dart';
import 'package:faceDetector/services/facenet.service.dart';
import 'package:faceDetector/services/ml_vision_service.dart';
import 'package:faceDetector/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginView extends StatefulWidget {
  @override
  LoginViewState createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  String email = "";
  String password = "";

  FaceNetService _faceNetService = FaceNetService();
  MLVisionService _mlVisionService = MLVisionService();
  DataBaseService _dataBaseService = DataBaseService();

  CameraDescription cameraDescription;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  /// 1 Obtain a list of the available cameras on the device.
  /// 2 loads the face net model
  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) => camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    _mlVisionService.initialize();

    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: RaisedButton(onPressed: (){Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AdminLoginView()));
            }, child: Text("Admin", style: TextStyle(color: Colors.black),)),
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
                // _formView(),
                 _loginButtonView(),
                SizedBox(height: 10),
                _registerButtonView(),
                SizedBox(height: 50),
                _forgotPasswordView(),
                SizedBox(height: 50),
                // _buildLoginOptions(),
                // SizedBox(height: 50),
                _registerBottomView()
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text('App Name',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: Colors.amber))
          ],
        )
      ],
    );
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
          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignIn(
                            cameraDescription: cameraDescription,
                          ),
                        ),
                      );
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

  Widget _registerButtonView() {
    return Container(
      height: 44,
      width: 148,
      child: RaisedButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        onPressed: () {
          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignUp(
                            cameraDescription: cameraDescription,
                          ),
                        ),
                      );
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

  Widget _registerBottomView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don’t have an account?'),
        SizedBox(width: 5),
        FlatButton(
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterView())))
      ],
    );
  }
}
