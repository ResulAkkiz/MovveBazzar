import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, IconData> genderMap = {
    'Male': Icons.male,
    'Female': Icons.female,
    'Other': Icons.transgender
  };
  TextEditingController controller = TextEditingController();
  DateTime dateTime = DateTime.now();
  ImagePicker imagePicker = ImagePicker();
  int choose = 0;
  File? gamePhoto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 150.0),
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
                      hintText: 'Email', iconData: Icons.email),
                  buildLoginTextformField(
                      hintText: 'Username', iconData: Icons.account_box),
                  buildLoginTextformField(
                      hintText: 'Phone Number', iconData: Icons.phone_android),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: buildLoginTextformField(
                            hintText: 'Age',
                            iconData: Icons.file_download_outlined),
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
                            controller: controller,
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
                                padding: const EdgeInsets.all(18.0),
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
                height: 20,
              )),
            ),
          ],
        ));
  }

  Align _buildSignoutButton() {
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
        onPressed: () {},
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
          height: 200.0,
        ),
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return Positioned(
      left: 12,
      top: 110,
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
                      },
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.photo_album, color: Colors.white),
                      title: const Text('Gallery'),
                      onTap: () {
                        _galeridenSec();
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
