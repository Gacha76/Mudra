import 'dart:io';
import 'package:classico/constants/colors.dart';
import 'package:classico/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _profileImage;

  Future<void> _getImage(ImageSource source, String type) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);

      setState(() {
        _profileImage = imageFile;
        // save profile image path
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('profileImagePath', _profileImage!.path);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final profileImagePath = prefs.getString('profileImagePath');
      if (profileImagePath != null) {
        setState(() {
          _profileImage = File(profileImagePath);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text('Profile View'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icon/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200,
                  child: Container(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('assets/images/welcome.jpeg')
                              as ImageProvider<Object>,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  onPressed: () {
                    _getImage(ImageSource.gallery, 'profile');
                  },
                  child: const Text(
                    'Change Profile Picture',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.transparent.withOpacity(0),
                    foregroundColor: Colors.white,
                    side: const BorderSide(width: 1, color: Colors.white),
                  ),
                  onPressed: () {
                    // Navigate to personal details screen
                  },
                  child: const Text('Personal Details'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.transparent.withOpacity(0),
                    foregroundColor: Colors.white,
                    side: const BorderSide(width: 1, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(appointment);
                  },
                  child: const Text('Schedule Appointment'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.transparent.withOpacity(0),
                    foregroundColor: Colors.white,
                    side: const BorderSide(width: 1, color: Colors.white),
                  ),
                  onPressed: () {
                    // Navigate to settings screen
                  },
                  child: const Text('Settings'),
                ),
              ],
            ),
          ),
        ));
  }
}
