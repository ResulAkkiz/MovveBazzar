import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  int choose = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[_buildClipPath(), _buildCircleAvatar()],
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
                ).separated(const SizedBox(
                  width: 15,
                )),
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
              ],
            ).separated(const SizedBox(
              height: 20,
            )),
          ),
        ],
      )),
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

  Positioned _buildCircleAvatar() {
    return Positioned(
      left: 12,
      top: 110,
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(ImageEnums.profilepicture.toPath),
              radius: 64,
            ),
          ],
        ),
      ),
    );
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
