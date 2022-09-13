import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController phoneController;
  late TextEditingController ageController;
  late TextEditingController datecontroller;

  @override
  void initState() {
    emailController = TextEditingController();
    usernameController = TextEditingController();
    phoneController = TextEditingController();
    ageController = TextEditingController();
    datecontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    datecontroller.dispose();
    super.dispose();
  }

  Map<String, IconData> genderMap = {
    'Male': Icons.male,
    'Female': Icons.female,
    'Other': Icons.transgender
  };

  DateTime dateTime = DateTime.now();
  ImagePicker imagePicker = ImagePicker();
  int choose = 0;
  File? gamePhoto;

  @override
  Widget build(BuildContext context) {
    MovierViewModel movierViewModel = Provider.of<MovierViewModel>(context);
    if (movierViewModel.movier != null) {
      emailController.text = movierViewModel.movier!.movierEmail;
      usernameController.text = movierViewModel.movier!.movierUsername;
    }

    return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 90.0),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                _buildClipPath(),
                _buildCircleAvatar(),
                _buildSignoutButton()
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildLoginTextformField(
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      iconData: Icons.email,
                      controller: emailController),
                  buildLoginTextformField(
                      hintText: 'Username',
                      iconData: Icons.account_box,
                      controller: usernameController),
                  buildLoginTextformField(
                      keyboardType: TextInputType.phone,
                      hintText: 'Phone Number',
                      iconData: Icons.phone_android,
                      controller: phoneController),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: buildLoginTextformField(
                            keyboardType: TextInputType.number,
                            hintText: 'Age',
                            iconData: Icons.file_download_outlined,
                            controller: ageController),
                      ),
                      Flexible(
                        flex: 1,
                        child: buildDateTimePicker(
                            onSelected: (DateTime date) {
                              setState(() {
                                dateTime = date;
                                debugPrint(dateTime.toString());
                              });
                            },
                            controller: datecontroller,
                            iconData: Icons.date_range,
                            context: context),
                      )
                    ],
                  ).separated(
                    const SizedBox(
                      width: 15,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Select your gender',
                        style: TextStyles.robotoRegular32Style,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: genderMap.entries.map((entry) {
                          int index =
                              genderMap.values.toList().indexOf(entry.value);
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  choose = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      entry.value,
                                      color: choose == index
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      size: 45,
                                    ),
                                    Text(
                                      entry.key,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: TextStyles.robotoBold18Style,
                    ),
                  ),
                ],
              ).separated(const SizedBox(
                height: 15,
              )),
            ),
          ],
        ));
  }

  Align _buildSignoutButton() {
    final movierViewModel = Provider.of<MovierViewModel>(context);
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        iconSize: 30,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        icon: const Icon(
          Icons.logout,
        ),
        onPressed: () async {
          await movierViewModel.signOut();
        },
      ),
    );
  }

  Positioned _buildClipPath() {
    return Positioned(
      child: ClipPath(
        clipper: MyCustomClipper(),
        child: Container(
          color: const Color(0xFFE11A38),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
        ),
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return Positioned(
      left: 12,
      top: MediaQuery.of(context).size.height * 0.10,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Theme.of(context).primaryColor,
              context: context,
              builder: (context) {
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                      title: const Text('Camera'),
                      onTap: () {
                        _kameradanCek();
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.photo_album, color: Colors.white),
                      title: const Text('Gallery'),
                      onTap: () {
                        _galeridenSec();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
        child: CircleAvatar(
          backgroundImage: gamePhoto != null
              ? FileImage(gamePhoto!) as ImageProvider
              : AssetImage(ImageEnums.profilepicture.toPath),
          radius: 64,
        ),
      ),
    );
  }

  void _kameradanCek() async {
    var yeniResim = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      gamePhoto = (File(yeniResim!.path));
    });
  }

  void _galeridenSec() async {
    var yeniResim = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      gamePhoto = (File(yeniResim!.path));
    });
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 60, size.width / 2, size.height - 30);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipper oldClipper) => false;
}
