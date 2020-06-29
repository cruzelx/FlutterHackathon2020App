import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hackathon_2020_app/screens/eventLocationMapScreen.dart';
import 'package:flutter_hackathon_2020_app/screens/mainPage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_hackathon_2020_app/services/firestoreDataQuery.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  DataQuery _newQuery = new DataQuery();

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _phoneNumberController;
  TextEditingController _emailController;

  final Widget loginImage = SvgPicture.asset(
    'assets/images/createEvent.svg',
    semanticsLabel: 'Create Event Logo',
  );

  final List<String> categories = [
    "Environment sanitation",
    "Drinking Water",
    "Health Campaign",
    "Animal Protection"
  ];
  String _category = "Environment sanitation";

  String eventDate = "Pick the event date";

  File _coverImage;

  String _uploadedImageFileUrl;

  final picker = ImagePicker();
  String _filename;

  DateTime _storeDate;

  List<double> _pickedLocation;

  Future getImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _coverImage = File(pickedImage.path);
      _filename = basename(pickedImage.path);
    });
  }

  _uploadData() async {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _storeDate != null &&
        _category != null &&
        _pickedLocation != null &&
        _filename != null) {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('images/${_filename}}');
      StorageUploadTask uploadTask = storageReference.putFile(_coverImage);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          print(fileURL);
          _uploadedImageFileUrl = fileURL;
        });
      });

      String title = _titleController.text.toString();
      String description = _descriptionController.text.toString();
      String phoneNumber = _phoneNumberController.text.toString();
      String email = _emailController.text.toString();
      DateTime eventDate = _storeDate;
      String category = _category;
      String imageFile = _uploadedImageFileUrl;
      List<double> pickedLocation = _pickedLocation;

      await _newQuery.createEvent({
        "title": "$title",
        "description": "$description",
        "phoneNumber": "$phoneNumber",
        "email": "$email",
        "eventDate": "$eventDate",
        "category": "$category",
        "imageFile": "$imageFile"
      });
    } else {
      print("Error creating event :(");
    }

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images/${_filename}}');
    StorageUploadTask uploadTask = storageReference.putFile(_coverImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        print(fileURL);
        _uploadedImageFileUrl = fileURL;
      });
    });

    String title = _titleController.text.toString();
    String description = _descriptionController.text.toString();
    String phoneNumber = _phoneNumberController.text.toString();
    String email = _emailController.text.toString();
    DateTime eventDate = _storeDate;
    String category = _category;
    String imageFile = _uploadedImageFileUrl;
    List<double> pickedLocation = _pickedLocation;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff0f0f0),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          loginImage,
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text("Be The Change",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0))),
                          ))
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                text: "Create",
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Event",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23.0))
                                ]),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Title",
                                prefixIcon: Icon(Icons.title)),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            maxLines: 2,
                            maxLength: 200,
                            decoration: InputDecoration(
                                hintText: "Description",
                                prefixIcon: Icon(Icons.description)),
                          ),
                          SizedBox(height: 15.0),
                          RaisedButton(
                            elevation: 3.0,
                            textColor: Colors.white,
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.location_on),
                                Spacer(),
                                _pickedLocation != null
                                    ? Text(
                                        "${_pickedLocation[0]},${_pickedLocation[1]}",
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text("Pick Event Location"),
                                Spacer(),
                              ],
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(context,
                                  new CupertinoPageRoute(
                                      builder: (BuildContext context) {
                                return EventLocationMapScreen();
                              }));

                              setState(() {
                                _pickedLocation = result;
                              });
                              print(result);
                            },
                          ),
                          SizedBox(height: 15.0),
                          RaisedButton(
                            elevation: 3.0,
                            textColor: Colors.white,
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.image),
                                Spacer(),
                                _filename != null
                                    ? Text(
                                        "$_filename",
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text("Upload Cover Photo"),
                                Spacer(),
                              ],
                            ),
                            onPressed: () {
                              getImage();
                            },
                          ),
                          SizedBox(height: 15.0),
                          RaisedButton(
                            elevation: 3.0,
                            textColor: Colors.white,
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2021))
                                  .then((value) {
                                print(DateFormat("yMMMMd").format(value));
                                setState(() {
                                  _storeDate = value;
                                  eventDate = DateFormat("yMMMMd")
                                      .format(value)
                                      .toString();
                                });
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.calendar_today),
                                Spacer(),
                                Text(eventDate),
                                Spacer()
                              ],
                            ),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintText: "Phone Number",
                                prefixIcon: Icon(Icons.phone_android)),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding: EdgeInsets.all(7.0),
                                    child: Text(
                                      "Pick Category",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                              Spacer(),
                              DropdownButton<String>(
                                value: _category,
                                icon: Icon(Icons.category),
                                iconSize: 25.0,
                                elevation: 16,
                                underline: Container(
                                  height: 2,
                                  color: Colors.redAccent,
                                ),
                                onChanged: (String newVal) {
                                  setState(() {
                                    _category = newVal;
                                  });
                                },
                                items: categories.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () async {
                                await _uploadData();
                                Navigator.push(context, CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                  return LandingPage();
                                }));
                              },
                              elevation: 3.0,
                              textColor: Colors.white,
                              color: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Text("Submit"),
                            ),
                          )
                        ],
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
