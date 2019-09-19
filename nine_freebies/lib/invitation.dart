import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'loaders/color_loader_2.dart';
import 'ad_info_screen.dart';
import 'utils.dart';

class InvitationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Invitation()
    ); 
  }
}

class Invitation extends StatefulWidget {
  @override
  InvitationForm createState() => InvitationForm();
}

class InvitationForm extends State<Invitation> {

  final _invitationQuiz = InvitationQuiz();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/nine_freebies_logo.png'),
        backgroundColor: new Color(0xff1b2d36),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formKey,
        child: Theme(
          data: Theme.of(context).copyWith(
            backgroundColor: hexToColor("#1b2d36"),
            accentColor: hexToColor("#1b2d36"),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                fontSize: 14.0
              )
            )
          ),
          child: CardSettings.sectioned(
            children: <CardSettingsSection>[
              CardSettingsSection(
                header: CardSettingsHeader(label: 'Trial Invitation'),
                instructions: CardSettingsInstructions(
                    text: 'A trial invitation for a new freebie is available! \nAnswer the questions below to see if it\'s right for you!'
                  ),
              ),
              CardSettingsSection(
                header: CardSettingsHeader(label: 'Drinks'),
                children: <Widget>[
                  CardSettingsMultiselect(
                    label: 'Which of the following do you consume at least weekly?',
                    initialValues: _invitationQuiz.consumedDrinks,
                    options: drinkTypes,
                    validator: (List<String> value) {
                      if (value == null || value.isEmpty)
                        return 'You must pick at least one drink type.';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _invitationQuiz.consumedDrinks = value;
                      });
                    }
                  ),
                  CardSettingsMultiselect(
                    label: 'Which of the following kinds of milk do you consume most often?',
                    initialValues: _invitationQuiz.milkTypes,
                    options: allMilk,
                    visible: _invitationQuiz.consumedDrinks.contains('Milk'),
                    validator: (List<String> value) {
                      if (value == null || value.isEmpty)
                        return 'You must pick at least one type of milk.';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _invitationQuiz.milkTypes = value;
                      });
                    }
                  ),
                  CardSettingsMultiselect(
                    label: 'Why do you choose your lactose free milk?',
                    initialValues: _invitationQuiz.lactoseChoice,
                    options: milkReasons,
                    visible: _invitationQuiz.milkTypes.contains('Other lactose free milk'),
                    validator: (List<String> value) {
                      if (value == null || value.isEmpty)
                        return 'You must pick at least one reason.';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _invitationQuiz.lactoseChoice = value;
                      });
                    }
                  ),
                ]
              ),
              CardSettingsSection(
                children: <Widget>[
                  CardSettingsButton(
                    label: 'Continue',
                    onPressed: _savePressed,
                    visible: quizFinished(_invitationQuiz),
                    backgroundColor: Colors.blueAccent,
                    bottomSpacing: 4.0
                  ),
                ]
              )
            ]
          )
        )
      )
    );
  }

  bool quizFinished(InvitationQuiz invitationQuiz) {
    
    // This horrifically ugly nested set of spaghetti ifs just makes the button to continue dynamic
    // based on whether you've selected any or of a specific type of answer for previous questions

    if (invitationQuiz.consumedDrinks.contains('Milk')) {
      if (invitationQuiz.milkTypes.contains('Other lactose free milk')) {
        if (invitationQuiz.lactoseChoice.contains('Lactose')) {
          return true;
        } else if (invitationQuiz.lactoseChoice.length > 0 && !invitationQuiz.consumedDrinks.contains('Lactose')) {
      return true;
    }
      } else if (invitationQuiz.milkTypes.length > 0 && !invitationQuiz.consumedDrinks.contains('Other lactose free milk')) {
      return true;
    }
    } else if (invitationQuiz.consumedDrinks.length > 0 && !invitationQuiz.consumedDrinks.contains('Milk')) {
      return true;
    }
    return false;
  }

  Future _savePressed() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      Navigator.push(context, MaterialPageRoute(builder: (context) => CouponLoadingPage()));
    }
  } 
}

class CouponLoadingPage extends StatefulWidget {
  @override
  _CouponLoadingPageState createState() => _CouponLoadingPageState();
}

class _CouponLoadingPageState extends State<CouponLoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((__) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AdInfoPage()));
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

class InvitationQuiz {
  
  List<String> consumedDrinks = <String> [];
  List<String> milkTypes = <String> [];
  List<String> lactoseChoice = <String> [];

}

const List<String> drinkTypes = <String>[
  'Orange juice',
  'Soft drink',
  'Milk',
  'Coffee',
  'Tea',
  'Sparkling water'
];

const List<String> allMilk = <String>[
  'Dairy milk',
  'Soy milk',
  'Nut-based milks',
  'Rice milk',
  'Oat milk',
  'Other lactose free milk'
];

const List<String> milkReasons = <String>[
  'Lactose intolerance',
  'Taste',
  'Price',
  'Health'
];