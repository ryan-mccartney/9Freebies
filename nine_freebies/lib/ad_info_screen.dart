import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'loaders/color_loader_2.dart';
import 'utils.dart';
import 'qrcode_presenter.dart';

class AdInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdInfo()
    ); 
  }
}

class AdInfo extends StatefulWidget {
  @override
  AdInfoForm createState() => AdInfoForm();
}

class AdInfoForm extends State<AdInfo> {


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
                header: CardSettingsHeader(label: 'A2 Milk'),
                instructions: CardSettingsInstructions(
                    text: 'Congrats, we have a new sample waiting for you!\nA new launch from A2 Milk, a lactose free milk from the number \n1 milk suppliers in Australia. '
                  ),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                      decoration: new BoxDecoration(          
                        color: Colors.white,                                            
                      ),                  
                      width: MediaQuery.of(context).size.width,
                      height: 290.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/a2_milk.png')
                          )
                        )
                      )
                  )
                ]
              ),
              CardSettingsSection(
                children: <Widget>[
                  CardSettingsInstructions(
                    text: 'Proceed to the next screen to receive your one-time QR Code!',
                  ),
                  CardSettingsButton(
                    label: 'Continue',
                    onPressed: _savePressed,
                    backgroundColor: Colors.blueAccent,
                    bottomSpacing: 4.0
                  )
                ]
              )
            ]
          )
        )
      )
    );
  }

  Future _savePressed() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      Navigator.push(context, MaterialPageRoute(builder: (context) => QRCodeLoadingPage()));
    }
  } 

}

class QRCodeLoadingPage extends StatefulWidget {
  @override
  _QRCodeLoadingPageState createState() => _QRCodeLoadingPageState();
}

class _QRCodeLoadingPageState extends State<QRCodeLoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((__) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => QRCodePage()));
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