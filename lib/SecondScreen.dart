import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SecondScreen extends StatefulWidget {
  final String username;
  final String nicNumber;
  final String contactNumber;
  final String emailAddress;
  final String gender;
  final DateTime? birthday;
  final File? initialImage;
  final String intname;

  const SecondScreen({
    Key? key,
    required this.username,
    required this.nicNumber,
    required this.contactNumber,
    required this.emailAddress,
    required this.gender,
    this.birthday,
    this.initialImage,
    required this.intname,
  }) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  File? image;

  @override
  void initState() {
    super.initState();
    image = widget.initialImage;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        image = File(selectedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: GestureDetector(
                onTap: pickImage,
                child: Column(
                  children: [
                    const Text('Input Details'),
                    if (image != null)
                      Container(
                        width: 100.0,
                        height: 100.0,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ClipOval(
                              child: Image.file(image!, fit: BoxFit.cover, width: 100.0, height: 100.0),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black38,
                              ),
                              child: const Icon(Icons.linked_camera_outlined, color: Colors.white, size: 24.0),
                            ),
                          ],
                        ),
                      ),
                    if (image == null)
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            ListTile(title: Text('Name with Initials: ${widget.intname}')),
            ListTile(title: Text('NIC Number: ${widget.nicNumber}')),
            ListTile(title: Text('Birthday: ${widget.birthday != null ? DateFormat('yyyy-MM-dd').format(widget.birthday!) : 'Not available'}')),
            ListTile(title: Text('Contact Number: ${widget.contactNumber}')),
            ListTile(title: Text('Email Address: ${widget.emailAddress}')),
            ListTile(title: Text('Gender: ${widget.gender}')),
            // Add more ListTiles if needed
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to the Second Screen!'),
      ),
    );
  }
}
