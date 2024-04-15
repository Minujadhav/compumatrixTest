import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package
import 'dart:io';
import 'profile_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color button1Color = Colors.transparent;
  Color button2Color = Colors.transparent;
  bool showImage = true;
  bool showAvatar = false;
  String? selectedImagePath;

  File? imageFile;

  Future<void> _openPhotoLibrary() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {

        selectedImagePath = pickedImage.path;

        imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {

        selectedImagePath = pickedImage.path;

        imageFile = File(pickedImage.path);
      });
    }
  }

  void _showOptionsModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: ListView(
            children: [
              ListTile(
                title: const Text(
                  'Upload your Photo',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('View Photo Library'),
                onTap: () {

                  _openPhotoLibrary();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {

                  _openCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),

                title: const Text(
                  'Remove a Photo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {

                  setState(() {
                    selectedImagePath = null;
                    imageFile = null;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery
        .of(context)
        .size
        .width * 0.7; // Adjust as needed
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),

            ),
            SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose profile photo.",
                    style: TextStyle(color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'FontMain'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Choose a profile photo from your library or select an avatar to add to your profile.",
                    style: TextStyle(color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            button1Color = Colors.blue; // Change button 1 color
                            button2Color =
                                Colors.transparent; // Reset button 2 color
                            showImage = true;
                            showAvatar = false;
                          });
                        },
                        child: Text('Choose Photo', style: TextStyle(
                            color: Colors.white, fontFamily: 'Poppins')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: button1Color, // Use button 1 color
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            button1Color =
                                Colors.transparent; // Reset button 1 color
                            button2Color = Colors.blue; // Change button 2 color
                            showImage = false;
                            showAvatar = true;
                          });
                        },
                        child: Text('Avatar', style: TextStyle(color: Colors
                            .white, fontFamily: 'Poppins')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: button2Color, // Use button 2 color
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            if (showImage)
              Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: _openPhotoLibrary,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 50,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width - 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: imageFile != null
                              ? DecorationImage(
                            image: FileImage(imageFile!),
                            // Use FileImage for local files
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 110),
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: _showOptionsModal,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt),
                              Text(
                                'Edit Photo',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            if (showAvatar)
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                children: [
                  'assets/image1.png',
                  'assets/image2.png',
                  'assets/image3.png',
                  'assets/image4.png',
                  'assets/image5.png',
                  'assets/image6.png',
                  'assets/image7.png',
                  'assets/image8.png',
                  'assets/boy.jpg',
                  'assets/image10.png',
                  'assets/image11.png',
                  'assets/image12.png',
                  'assets/image13.png',
                  'assets/image14.png',
                  'assets/image15.png',
                  'assets/image16.png',
                ].map((imagePath) {
                  return GestureDetector(
                    onTap: () {

                      setState(() {
                        selectedImagePath = imagePath;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),

                      child: Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(imagePath),
                              radius: screenWidth * 0.15,
                            ),
                          ),
                          if (selectedImagePath == imagePath)
                            Center(
                              child: CircleAvatar(
                                radius: screenWidth * 0.15,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            Profile_Page(selectedImagePath: selectedImagePath)),
                      );


                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      elevation: MaterialStateProperty.all(0),

                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                          Size(screenWidth * 0.9, screenHeight * 0.06)),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}