import 'package:faceDetector/constants/Assets.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
const ProfileView({Key key, @required this.username}) : super(key: key);
  // ProfileView({@required this.username});

  final String username;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

enum Options { camera, gallery }

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'My Profile',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _profileImage(context),
              SizedBox(height: 5),
              _fullNameTextFieldView(context),
              Divider(),
              // _mobileTextFieldView(context),
              // Divider(),
              // _emailTextFieldView(context),
              // Divider(),
              // _addressTextFieldView(context),
              // Divider(),
              SizedBox(height: 40),
              _otherSettingsText(),
              SizedBox(height: 20),
              // _otherSettingsOptions(context)
            ],
          )),
    );
  }

  Widget _profileImage(context) {
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.avatarImg),
                  radius: 70.0,
                  backgroundColor: Colors.blue,
                ),
                Positioned(
                  top: 120,
                  left: 50,
                  child: Container(
                    padding: EdgeInsets.only(),
                    child: ClipOval(
                      child: Material(
                        color: Colors.blue, // button color
                        child: InkWell(
                          splashColor: Colors.red, // inkwell color
                          child: SizedBox(
                            width: 44,
                            height: 44,
                            child: PopupMenuButton<Options>(
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                              ),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<Options>>[
                                const PopupMenuItem<Options>(
                                  value: Options.gallery,
                                  child: Text('Choose from Gallery',
                                      style: TextStyle(fontSize: 12)),
                                ),
                                const PopupMenuItem<Options>(
                                  value: Options.camera,
                                  child: Text(
                                    'Take Photo',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                )
                              ],
                              // onSelected: (Options result) {
                              //   if (result == Options.camera) {
                              //     _getFromCamera();
                              //   } else {
                              //     _getFromGallery();
                              //   }
                              // },
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _fullNameTextFieldView(context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("First Name"),
          Text(
            widget.username,
            style:
                TextStyle(color: Colors.blue[600], fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _otherSettingsText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Text("Other Settings")],
    );
  }


  // _getFromGallery() async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  // }

  // /// Get from Camera
  // _getFromCamera() async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   // _cropImage(pickedFile.path);
  // }

}
