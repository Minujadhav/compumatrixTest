import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task1/screens/photos_and_avatar.dart';

class Profile_Page extends StatefulWidget {
  final String? selectedImagePath;

  const Profile_Page({Key? key, this.selectedImagePath}) : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController yearOfBirthController = TextEditingController();
  String? selectedYearOfBirth;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double avatarSize = screenWidth * 0.25; // Adjust avatar size based on screen width
    double buttonWidth = screenWidth * 0.3; // Adjust button width based on screen width

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: screenHeight * 0.13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Let\'s  get to know you ',
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontSize: screenWidth * 0.06, // Adjust font size based on screen width
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Let us get to know you a bit better so you can get the best out of us',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.04, // Adjust font size based on screen width
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: CircleAvatar(
                            backgroundImage: widget.selectedImagePath != null ? AssetImage(widget.selectedImagePath!) : null,
                            radius: avatarSize,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: SizedBox(
                            width: buttonWidth, // Set the width of the button
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyHomePage()),
                                );

                              },
                              style: ButtonStyle(

                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                minimumSize: MaterialStateProperty.all(Size(buttonWidth, screenHeight * 0.06)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.camera_alt),
                                  SizedBox(width: screenWidth * 0.02),
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'First Name ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your First Name',
                    contentPadding: EdgeInsets.all(10.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Last Name ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Last Name',
                    contentPadding: EdgeInsets.all(10.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Year Of Birth ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value: selectedYearOfBirth,
                items: List.generate(125, (index) => (1900 + index).toString())
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedYearOfBirth = newValue!;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Year Of Birth',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        elevation: MaterialStateProperty.all(0), // Remove elevation
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(Size(buttonWidth * 9, screenHeight * 0.06)),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.04,
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
      ),
    );
  }
}
