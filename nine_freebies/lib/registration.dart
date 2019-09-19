import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'loaders/color_loader_2.dart';
import 'main.dart';
import 'utils.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Registration()
    ); 
  }
}

class Registration extends StatefulWidget {
  @override
  RegistrationForm createState() => RegistrationForm();
}

class RegistrationForm extends State<Registration> {

  final _user = User();

  // flipped to true after submission, triggering autovalidation
  bool _autoValidate = false;

    // Key for saving form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();


  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formKey,
        child: Theme(
          data: Theme.of(context).copyWith(
            backgroundColor: hexToColor("#1b2d36"),
            accentColor: hexToColor("#1b2d36"),
          ),
          child: CardSettings.sectioned(
            children: <CardSettingsSection>[
              CardSettingsSection(
                header: CardSettingsHeader(label: 'About You'),
                children: <Widget>[
                  CardSettingsText(
                    label: 'First Name',
                    initialValue: _user.firstName,
                    autovalidate: _autoValidate,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'First Name is required.';
                    },
                    onSaved: (value) => _user.firstName = value,
                    onChanged: (value) {
                      setState(() {
                        _user.firstName = value;
                      });
                    },
                  ),
                  CardSettingsText(
                    label: 'Last Name',
                    initialValue: _user.lastName,
                    autovalidate: _autoValidate,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Last Name is required.';
                    },
                    onSaved: (value) => _user.lastName = value,
                    onChanged: (value) {
                      setState(() {
                        _user.lastName = value;
                      });
                    },
                  ),
                  CardSettingsEmail(
                    icon: Icon(Icons.email),
                    initialValue: _user.email,
                    autovalidate: _autoValidate,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email is required.';
                      if (!value.contains('@'))
                        return "Email not formatted correctly.";
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _user.email = value;
                      });
                    },
                  ),
                    //onSaved: (value) => email = value,),
                  CardSettingsNumberPicker(
                    label: 'Age',
                    initialValue: _user.age,
                    min: 18,
                    max: 99,
                    autovalidate: _autoValidate,
                    validator: (value) {
                      if (value == null) return 'Age is required';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _user.age = value;
                      });
                    },
                  ),
                  CardSettingsListPicker(
                    label: 'Gender',
                    hintText: 'Select gender...',
                    initialValue: _user.gender,
                    autovalidate: _autoValidate,
                    options: <String>['Male', 'Female', 'Other'],
                    validator: (String value) {
                      if (value == null || value.isEmpty) return 'You must pick a gender.';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _user.gender = value;
                      });
                    }
                  ),
                  CardSettingsListPicker(
                    label: 'Location (State)',
                    hintText: 'Select state...',
                    initialValue: _user.location,
                    autovalidate: _autoValidate,
                    options: <String>['NSW', 'SA', 'ACT', 'NT', 'WA', 'QLD', 'VIC'],
                    validator: (String value) {
                      if (value == null || value.isEmpty) return 'You must pick a state.';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _user.location = value;
                      });
                    }
                  ),
                  CardSettingsMultiselect(
                    label: 'Interests',
                    initialValues: _user.interests,
                    autovalidate: _autoValidate,
                    options: allInterests,
                    validator: (List<String> value) {
                      if (value == null || value.isEmpty || value.length < 3)
                        return 'You must pick at least three (3) interests.';

                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _user.interests = value;
                      });
                    }
                  ),
                  CardSettingsListPicker(
                    label: 'Employment Status',
                    hintText: 'Select employment status...',
                    initialValue: _user.employmentStatus,
                    autovalidate: _autoValidate,
                    options: <String>['full time', 'part time', 'studying', 'run my own business', 'unemployed'],
                    validator: (String value) {
                      if (value == null || value.isEmpty) return 'You must pick an employment status.';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _user.employmentStatus = value;
                      });
                    }
                  ),
                ], 
              ),
              CardSettingsSection(
                header: CardSettingsHeader(label: 'About Your Family'),
                children: <Widget>[
                  CardSettingsSwitch(
                    label: 'Baby on the way?',
                    initialValue: _user.babySoon,
                    onChanged: (value) {
                      setState(() {
                        _user.babySoon = value;
                      });
                    },
                  ),
                  CardSettingsNumberPicker(
                    label: 'Number of kids',
                    initialValue: _user.numberOfKids,
                    min: 0,
                    max: 10,
                    autovalidate: _autoValidate,
                    validator: (value) {
                      if (value == null) return 'Number of kids is required';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _user.numberOfKids = value;
                      });
                    },
                  ),
                  CardSettingsSwitch(
                    label: 'Any pets owned?',
                    initialValue: _user.anyPets,
                    onChanged: (value) {
                      setState(() {
                        _user.anyPets = value;
                      });
                    },
                  ),
                  CardSettingsMultiselect(
                    label: 'Types of pets owned',
                    initialValues: _user.petsOwned,
                    autovalidate: _autoValidate,
                    options: allPets,
                    visible: _user.anyPets,
                    validator: (List<String> value) {
                      if (value == null || value.isEmpty)
                        return 'You must pick at least one pet.';

                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _user.petsOwned = value;
                      });
                    }
                  ),
                ]
              ),
              CardSettingsSection(
                header: CardSettingsHeader(
                  label: 'Complete registration',
                ),
                children: <Widget>[
                  CardSettingsSwitch(
                    label: 'Agree to T&C\'s?',
                    initialValue: _user.agree,
                    onChanged: (value) {
                      setState(() {
                        _user.agree = value;
                      });
                    },
                  ),
                  CardSettingsButton(
                    label: 'Register',
                    onPressed: _savePressed,
                    visible: _user.agree,
                    backgroundColor: Colors.blueAccent,
                    bottomSpacing: 2.0
                  ),
                ]
              )
            ],
          )
        )
      ),
    );
  }

  Future _savePressed() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingPage()));
    } else {
      setState(() => _autoValidate = true);
    }
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((__) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#1b2d36"),
      body: Center(
        child: Container(
          color: hexToColor("#1b2d36"),
          child: ColorLoader2 (
          color1: Colors.lightBlueAccent,
          color2: Colors.redAccent,
          color3: Colors.blueAccent
        )
        )
      )
    ); // this widget stays here for 2 seconds
  }
}

class User {
  // About You
  String firstName = "Ryan";
  String lastName = "McCartney";
  String gender;
  int age = 22; 
  String email;
  String location;
  List<String> interests = <String> [
    'movies',
    'programming',
    'hackathons'
  ];
  String employmentStatus;

  // About Your Family
  bool babySoon = false;
  int numberOfKids = 0;
  bool anyPets = false;
  List<String> petsOwned = <String>[];

  // Complete
  bool agree = false;
}

const List<String> allInterests = <String>[
  'food',
  'alcohol',
  'books',
  'cosmetics',
  'health and fitness',
  'video games',
  'board games and tabletop',
  'singing',
  'programming',
  'hackathons',
  'movies',
  'music',
  'dancing',
  'acting',
  'shopping',
  'sewing',
  'cooking',
];

const List<String> allPets = <String>[
  'dog',
  'cat',
  'bird',
  'lizard',
  'cow',
  'sloth',
  'other'
];